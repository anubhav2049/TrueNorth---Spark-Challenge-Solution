import SwiftUI



struct StepsView: View {
    @Binding var path: NavigationPath
    @State private var doText: String = ""
    @State private var dontText: String = ""
    @State private var isLoading = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Action to Take")
                .font(.largeTitle)
                .padding(.top)

            VStack(alignment: .leading, spacing: 10) {
                Text("What can you do?")
                    .font(.headline)

                TextEditor(text: $doText)
                    .frame(height: 120)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.green.opacity(0.5), lineWidth: 1)
                    )
            }

            VStack(alignment: .leading, spacing: 10) {
                Text("What should you NOT do?")
                    .font(.headline)

                TextEditor(text: $dontText)
                    .frame(height: 120)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.red.opacity(0.5), lineWidth: 1)
                    )
            }

            if isLoading {
                ProgressView("Generating suggestions...")
            }

            Spacer()

            Button("Continue") {
                fetchAISuggestions()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .disabled(isLoading)
        }
        .padding()
        .navigationTitle("Steps")
    }

    func fetchAISuggestions() {
        guard !doText.isEmpty else { return }
        isLoading = true

        let url = URL(string: "https://models.inference.ai.azure.com/chat/completions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let token = "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"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("gpt-4o", forHTTPHeaderField: "x-ms-model-mesh-model-name")

        let prompt = "The user said they can do the following: \(doText). Based on this, generate a summarized short list of what the user said ONLY. Return just the list, no explanation."

        let body: [String: Any] = [
            "messages": [
                ["role": "system", "content": "You are a mental health assistant that gives friendly and simple advice."],
                ["role": "user", "content": prompt]
            ],
            "temperature": 0.7,
            "top_p": 1.0,
            "max_tokens": 200
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

            let suggestions = content
                .components(separatedBy: .newlines)
                .map { $0.replacingOccurrences(of: "^[\\d\\-•\\.\\s]*", with: "", options: .regularExpression) }
                .filter { !$0.isEmpty }

            DispatchQueue.main.async {
                path.append(Screen.actionPlan(suggestions: suggestions))

            }
        }.resume()
    }
}
