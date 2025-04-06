import SwiftUI

struct GoalValidationView: View {
    let message: String
    @Binding var path: NavigationPath

    var body: some View {
        VStack(spacing: 20) {
            Text("AI Feedback")
                .font(.title)

            Text(message)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)

            Text("I hope you have more clarity about the situation.")
                .font(.footnote)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)

            Spacer()
            
            Button("Continue") {
                            path.removeLast(path.count) // ✅ Reset to ContentView
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
        }
        .padding()
        .navigationTitle("Validation")
    }
}

