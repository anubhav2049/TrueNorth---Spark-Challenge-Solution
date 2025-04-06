import SwiftUI

struct ShortTermGoalView: View {
    @State private var goal: String = ""
    @State private var isLoading = false
    @Binding var path: NavigationPath

    var body: some View {
        VStack(spacing: 20) {
            Text("Set a Short-Term Goal")
                .font(.title2)

            Text("What’s one small thing you can try to accomplish today or this week?")
                .multilineTextAlignment(.center)

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
            .background(goal.isEmpty || isLoading ? Color.gray : Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)

            Spacer()
        }
        .padding()
        .navigationTitle("Your Goal")
    }

    func getAIValidation() {
        isLoading = true

        let url = URL(string: "https://models.inference.ai.azure.com/chat/completions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let token = "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" // ← Replace with your actual key
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("gpt-4o", forHTTPHeaderField: "x-ms-model-mesh-model-name")

        let prompt = """
        A user set the following short-term goal: "\(goal)".
        Respond in 1–2 sentences validating or encouraging it as a supportive mental health assistant.
        """

        let body: [String: Any] = [
            "messages": [
                ["role": "system", "content": "You are a warm, supportive mental health assistant who encourages users."],
                ["role": "user", "content": prompt]
            ],
            "temperature": 0.8,
            "top_p": 1.0,
            "max_tokens": 100
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, _, _ in
            DispatchQueue.main.async { isLoading = false }

            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let choices = json["choices"] as? [[String: Any]],
                  let message = choices.first?["message"] as? [String: Any],
                  let content = message["content"] as? String else {
                print("❌ Failed to parse AI response")
                return
            }

            DispatchQueue.main.async {
                path.append(Screen.goalValidation(message: content))
            }
        }.resume()
    }
}

