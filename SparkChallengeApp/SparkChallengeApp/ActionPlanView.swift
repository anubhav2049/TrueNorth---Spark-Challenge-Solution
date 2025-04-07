import SwiftUI

struct ActionPlanView: View {
    let suggestions: [String]
    @State private var selectedOptions: Set<String> = []
    @Binding var path: NavigationPath

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(hex: "#FFA8FF"), Color(hex: "#A7B0FF")],
                startPoint: .trailing,
                endPoint: .leading
            )
            .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 20) {
                Text("Select the actions you want to take:")
                    .font(.title2)
                    .foregroundColor(.white)

                ForEach(suggestions, id: \.self) { option in
                    Toggle(isOn: Binding(
                        get: { selectedOptions.contains(option) },
                        set: { isOn in
                            if isOn {
                                selectedOptions.insert(option)
                            } else {
                                selectedOptions.remove(option)
                            }
                        }
                    )) {
                        Text(option)
                            .foregroundColor(.white)
                    }
                    .toggleStyle(CheckboxToggleStyle())
                }

                Button("Continue") {
                    path.append(Screen.shortTermGoal)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(hex: "#908DFF"))
                .foregroundColor(.white)
                .cornerRadius(10)

                Spacer()
            }
            .padding()
            .navigationTitle("Your Plan")
        }
    }
}

