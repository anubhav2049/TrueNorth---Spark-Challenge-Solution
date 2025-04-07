import SwiftUI

struct StepsView: View {
    @Binding var path: NavigationPath
    @State private var doText: String = ""
    @State private var dontText: String = ""
    @State private var isLoading = false

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(hex: "#FFA8FF"), Color(hex: "#A7B0FF")],
                startPoint: .trailing,
                endPoint: .leading
            )
            .ignoresSafeArea()

            VStack(spacing: 20) {
                Text("Action to Take")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.top)

                VStack(alignment: .leading, spacing: 10) {
                    Text("What can you do?")
                        .font(.headline)
                        .foregroundColor(.white)

                    TextEditor(text: $doText)
                        .frame(height: 120)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                }

                VStack(alignment: .leading, spacing: 10) {
                    Text("What should you NOT do?")
                        .font(.headline)
                        .foregroundColor(.white)

                    TextEditor(text: $dontText)
                        .frame(height: 120)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                }

                if isLoading {
                    ProgressView("Getting suggestions...")
                        .foregroundColor(.white)
                }

                Button("Continue") {
                    fetchAISuggestions()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(hex: "#908DFF"))
                .foregroundColor(.white)
                .cornerRadius(10)
                .disabled(isLoading)

                Spacer()
            }
            .padding()
            .navigationTitle("Steps")
        }
    }

    // MARK: - AI Call to OpenAI (matches ExplanationView)
    func fetchAISuggestions() {
        guard !doText.isEmpty else { return }
        isLoading = true

        let token = "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"
        let url = URL(string: "https://api.openai.com/v1/chat/completions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let prompt = "The user said they can do the following: \(doText). Based on this, summarize and generate a list based on that summary.Return only the list, no explanation."

        let messages: [[String: String]] = [
            ["role": "system", "content": "You are a mental health assistant that gives friendly and simple advice."],
            ["role": "user", "content": prompt]
        ]

        let body: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": messages,
            "temperature": 0.7,
            "top_p": 1.0,
            "max_tokens": 200
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        } catch {
            print("❌ Failed to encode body:", error)
            isLoading = false
            useFallbackSuggestions()
            return
        }

        URLSession.shared.dataTask(with: request) { data, _, error in
            DispatchQueue.main.async {
                isLoading = false
            }

            if let error = error {
                print("❌ Request error:", error.localizedDescription)
                useFallbackSuggestions()
                return
            }

            guard let data = data else {
                print("❌ No data received")
                useFallbackSuggestions()
                return
            }

            print("🔍 AI response:\n\(String(data: data, encoding: .utf8) ?? "Invalid JSON")")

            guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let choices = json["choices"] as? [[String: Any]],
                  let message = choices.first?["message"] as? [String: Any],
                  let content = message["content"] as? String else {
                print("❌ Failed to parse AI response")
                useFallbackSuggestions()
                return
            }

            let suggestions = content
                .components(separatedBy: .newlines)
                .map { $0.replacingOccurrences(of: "^[\\d\\-•\\.\\s]*", with: "", options: .regularExpression) }
                .filter { !$0.isEmpty }

            DispatchQueue.main.async {
                path.append(Screen.actionPlan(suggestions: suggestions))
            }
        }.resume()
    }

    // MARK: - Fallback Suggestions
    func useFallbackSuggestions() {
        let fallback = [
            "Take a 10-minute walk",
            "Write down 3 positive things",
            "Drink a glass of water",
            "Reach out to someone you trust",
            "Do a 1-minute breathing exercise"
        ]
        DispatchQueue.main.async {
            path.append(Screen.actionPlan(suggestions: fallback))
        }
    }
}

