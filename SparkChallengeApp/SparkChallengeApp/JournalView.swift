import SwiftUI

struct JournalView: View {
    @Binding var path: NavigationPath
    let moodValue: Int

    @State private var dayReflection: String = ""
    @State private var emotionalReflection: String = ""
    @State private var isSubmitting = false

    @EnvironmentObject var dailyLogManager: DailyLogManager

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(hex:"#FDFF7E"), Color(hex:"#FFB5AF")],
                startPoint: .trailing,
                endPoint: .leading
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Daily Journal")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)

                    Group {
                        Text("What happened today?")
                            .font(.headline)
                            .foregroundColor(.white)

                        TextEditor(text: $dayReflection)
                            .frame(height: 140)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                    }

                    Group {
                        Text("How are you feeling right now?")
                            .font(.headline)
                            .foregroundColor(.white)

                        TextEditor(text: $emotionalReflection)
                            .frame(height: 140)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                    }

                    if isSubmitting {
                        ProgressView("Saving...")
                            .frame(maxWidth: .infinity)
                            .padding()
                    } else {
                        Button("Continue") {
                            isSubmitting = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                let today = Date()
                                dailyLogManager.saveEntry(
                                    date: today,
                                    journal: dayReflection,
                                    feeling: emotionalReflection,
                                    moodRating: moodValue
                                )
                                isSubmitting = false
                                path.append(Screen.goalSetting(moodRating: moodValue))
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(hex: "#FF8B6C"))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }

                    Spacer()
                }
                .padding()
            }
        }
        .navigationTitle("Journal")
    }
}

