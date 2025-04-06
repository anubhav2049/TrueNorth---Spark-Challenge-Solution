import SwiftUI

struct ActionPlanView: View {
    let suggestions: [String]
    @State private var selectedOptions: Set<String> = []
    @Binding var path: NavigationPath

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Select the actions you want to take:")
                .font(.title2)

            ForEach(suggestions, id: \.self) { option in
                Toggle(option, isOn: Binding(
                    get: { selectedOptions.contains(option) },
                    set: { isOn in
                        if isOn {
                            selectedOptions.insert(option)
                        } else {
                            selectedOptions.remove(option)
                        }
                    }
                ))
                .toggleStyle(CheckboxToggleStyle())
            }

            Spacer()
            
            Button("Continue") {
                path.append(Screen.shortTermGoal)                        }
                       .frame(maxWidth: .infinity)
                       .padding()
                       .background(Color.blue)
                       .foregroundColor(.white)
                       .cornerRadius(10)
        }
        .padding()
        .navigationTitle("Your Plan")
    }
}


