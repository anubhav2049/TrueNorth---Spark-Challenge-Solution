import SwiftUI

struct ShortTermGoalView: View {
    @State private var goal: String = ""
    @State private var isLoading = false
    @Binding var path: NavigationPath

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(hex: "#FFA8FF"), Color(hex: "#A7B0FF")],
                startPoint: .trailing,
                endPoint: .leading
            )
            .ignoresSafeArea()

            VStack(spacing: 20) {
                Text("Set a Short-Term Goal")
                    .font(.title2)
                    .foregroundColor(.white)

                Text("What’s one small thing you can try to accomplish today or this week?")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)

                TextEditor(text: $goal)
                    .frame(height: 100)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue.opacity(0.4), lineWidth: 1)
                    )

                if isLoading {
                    ProgressView("Asking AI...")
                }

                Button("Continue") {
                    getAIValidation()
                }
                .disabled(goal.isEmpty || isLoading)
                .frame(maxWidth: .infinity)
                .padding()
                .background(goal.isEmpty || isLoading ? Color.gray : Color(hex: "#908DFF"))
                .foregroundColor(.white)
                .cornerRadius(10)

                Spacer()
            }
            .padding()
            .navigationTitle("Your Goal")
        }
    }

    // MARK: - OpenAI API Call (matches ExplanationView)
    func getAIValidation() {
        isLoading = true

        let token = "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"
        let url = URL(string: "https://api.openai.com/v1/chat/completions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let prompt = """
        A user set the following short-term goal: "\(goal)".
        Respond in 1–2 encouraging sentences validating this goal as a helpful assistant.
        """

        let messages: [[String: String]] = [
            ["role": "system", "content": "You are a warm and supportive mental health assistant. Keep your response under 100 words."],
            ["role": "user", "content": prompt]
        ]

        let body: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": messages,
            "temperature": 0.8,
            "top_p": 1.0,
            "max_tokens": 150
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        } catch {
            print("❌ JSON encoding failed:", error)
            fallbackAndContinue()
            return
        }

        URLSession.shared.dataTask(with: request) { data, _, error in
            DispatchQueue.main.async { isLoading = false }

            if let error = error {
                print("❌ Request error:", error.localizedDescription)
                fallbackAndContinue()
                return
            }

            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let choices = json["choices"] as? [[String: Any]],
                  let message = choices.first?["message"] as? [String: Any],
                  let content = message["content"] as? String else {
                print("❌ Failed to parse AI response")
                fallbackAndContinue()
                return
            }

            DispatchQueue.main.async {
                path.append(Screen.goalValidation(message: content))
            }
        }.resume()
    }

    // MARK: - Fallback if AI fails
    func fallbackAndContinue() {
        let message = "That sounds like a thoughtful and manageable goal. Taking even a small step can make a big difference. 😊"
        DispatchQueue.main.async {
            path.append(Screen.goalValidation(message: message))
        }
    }
}

