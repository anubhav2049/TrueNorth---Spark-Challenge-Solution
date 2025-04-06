import SwiftUI

struct ContentView: View {
    @State private var moodValue: Int = 5
    @Binding var path: NavigationPath

    var body: some View {
        ZStack{
            LinearGradient(
                    colors: [Color(hex:"#FFA8FF"), Color(hex:"#A7B0FF")],
                        startPoint: .trailing,
                        endPoint: .leading
                    )
                    .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text("How are you feeling today?")
                    .font(.title2)
                    .padding()
                    .foregroundColor(.white)
                
                Text("\(moodValue)")
                    .font(.system(size: 64))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Slider(value: Binding(
                    get: { Double(self.moodValue) },
                    set: { self.moodValue = Int($0) }
                ), in: 1...10, step: 1)
                .padding(.horizontal)
                
                Button("Continue") {
                    path.append(Screen.explanation(mood: moodValue))
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(hex: "#908DFF"))
                .foregroundColor(.white)
                .cornerRadius(10)
            
                .padding(.horizontal)
            }
            .padding()
            .navigationTitle("Mood Check-In")
            

        }
    }
}

