import SwiftUI


struct AISuggestionView: View {
    let suggestion: String
    @Binding var path: NavigationPath

    var body: some View {
        
        ZStack {
            LinearGradient(
                colors: [Color(hex:"#FFA8FF"), Color(hex:"#A7B0FF")],
                    startPoint: .trailing,
                    endPoint: .leading
            )
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("AI Suggestion")
                    .font(.title)
                
                Text(suggestion)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                
                Spacer()
                
                Button("Continue") {
                    path.append(Screen.steps)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(hex: "#908DFF"))
                .foregroundColor(.white)
                .cornerRadius(10)
                
                Spacer()
                Spacer()
               
            }
            .padding()
            .navigationTitle("Insight")
        }
    }
}
