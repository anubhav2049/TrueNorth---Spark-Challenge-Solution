import SwiftUI

struct GoalValidationView: View {
    let message: String
    @Binding var path: NavigationPath

    var body: some View {
        ZStack{
            LinearGradient(
                                colors: [Color(hex:"#FFA8FF"), Color(hex:"#A7B0FF")],
                                    startPoint: .trailing,
                                    endPoint: .leading
                                )
                                .ignoresSafeArea()



            VStack(spacing: 20) {
                Text("AI Feedback")
                    .font(.title)
                    .foregroundColor(.white)
                
                Text(message)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                
                Text("I hope you have more clarity about the situation.")
                    .font(.footnote)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
               
                
                Button("Back To Main Menu") {
                    path.removeLast(path.count) // ✅ Reset to ContentView
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(hex: "#908DFF"))
                .foregroundColor(.white)
                .cornerRadius(10)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Validation")
        }
    }
}

