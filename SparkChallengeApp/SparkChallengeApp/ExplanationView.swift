import SwiftUI

struct ExplanationView: View {
    let moodValue: Int
    @Binding var path: NavigationPath

    @State private var explanation: String = ""
    @State private var isLoading = false

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(hex: "#FFA8FF"), Color(hex: "#A7B0FF")],
                startPoint: .trailing,
                endPoint: .leading
            )
            .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 20) {
                Text("You selected: \(moodValue)")
                    .font(.headline)
                    .foregroundColor(.white)

                Text("What happened?")
                    .font(.title2)
                    .foregroundColor(.white)

                TextEditor(text: $explanation)
                    .frame(height: 200)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)

                if isLoading {
                    ProgressView("Getting suggestion...")
                        .frame(maxWidth: .infinity)
                }

                Button("Submit") {
                    getAISuggestion()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(isLoading ? Color.gray : Color(hex: "#908DFF"))
                .foregroundColor(.white)
                .cornerRadius(10)
                .disabled(isLoading)

                Spacer()
            }
            .padding()
            .navigationTitle("Reflection")
        }
    }

    // MARK: - API Request
    func getAISuggestion() {
        guard !explanation.isEmpty else { return }
        isLoading = true

        let token = "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"
        let url = URL(string: "https://api.openai.com/v1/chat/completions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let messages: [[String: String]] = [
            ["role": "system", "content": "You are an empathetic assistant. Keep your responses under 100 words."],
            ["role": "user", "content": "A user rated their mood as \(moodValue)/10 and said: \"\(explanation)\". What emotion might they be feeling and why?"]
        ]

        let body: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": messages,
            "temperature": 1.0,
            "top_p": 1.0,
            "max_tokens": 1000
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        } catch {
            print("❌ Failed to encode request body:", error)
            isLoading = false
            return
        }

        URLSession.shared.dataTask(with: request) { data, _, error in
            DispatchQueue.main.async {
                isLoading = false
            }

            if let error = error {
                print("❌ Request error: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("❌ No data received")
                return
            }

            print("🔍 Response: \(String(data: data, encoding: .utf8) ?? "Invalid JSON")")

            guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let choices = json["choices"] as? [[String: Any]],
                  let message = choices.first?["message"] as? [String: Any],
                  let content = message["content"] as? String else {
                print("❌ Failed to parse AI response")
                return
            }

            DispatchQueue.main.async {
                path.append(Screen.suggestion(text: content))
            }
        }.resume()
    }
}

