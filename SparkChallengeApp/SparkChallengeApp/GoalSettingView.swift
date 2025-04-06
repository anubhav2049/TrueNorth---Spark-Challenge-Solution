import SwiftUI

struct GoalSettingView: View {
    @EnvironmentObject var goalManager: GoalManager
    @EnvironmentObject var dailyLogManager: DailyLogManager

    @State private var goalTitle: String = ""
    @Binding var path: NavigationPath

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("What goals did you complete today?")
                    .font(.largeTitle)
                    .bold()

                TextField("Enter your goal", text: $goalTitle)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(maxWidth: .infinity)

                Button("Add Goal") {
                    guard !goalTitle.isEmpty else { return }
                    goalManager.addGoal(title: goalTitle)
                    goalTitle = ""
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)

                if goalManager.goals.isEmpty {
                    Text("No goals added yet.")
                        .foregroundColor(.gray)
                }

                ForEach(goalManager.goals) { goal in
                    HStack {
                        Text(goal.title)
                        Spacer()
                    }
                    .padding(.vertical, 6)
                    .padding(.horizontal)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(8)
                }

                // ✅ New "Submit" button that saves to the log
                Button("Submit Goals Completed") {
                    let today = Calendar.current.startOfDay(for: Date())

                    // Retrieve existing journal entry + feeling if they exist
                    let existingEntry = dailyLogManager.entries[today]
                    let journal = existingEntry?.journal ?? ""
                    let feeling = existingEntry?.feeling ?? ""

                    // ✅ Mark all goals as completed
                    let completedGoals = goalManager.goals.map { goal in
                        Goal(title: goal.title, isCompleted: true)
                    }

                    // ✅ Save everything into today's log
                    dailyLogManager.saveEntry(
                        date: today,
                        journal: journal,
                        feeling: feeling,
                        goals: completedGoals
                    )

                    path.removeLast(path.count)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.purple)
                .foregroundColor(.white)
                .cornerRadius(10)

//                Button("Continue to Main Menu") {
//                    path.removeLast(path.count)
//                }
//                .padding()
//                .frame(maxWidth: .infinity)
//                .background(Color.green)
//                .foregroundColor(.white)
//                .cornerRadius(10)
            }
            .padding()
        }
        .navigationTitle("Goal Setting")
        .background(
            LinearGradient(
                colors: [Color(hex: "#FFFDE1"), Color(hex: "#A1FFCE")],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )
    }
}

