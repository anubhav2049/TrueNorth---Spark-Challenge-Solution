import SwiftUI

struct MenuView: View {
    @State private var path = NavigationPath()
    @EnvironmentObject var dailyLogManager: DailyLogManager
    @EnvironmentObject var goalManager: GoalManager

    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                LinearGradient(
                    colors: [Color(hex: "#FFB947"), Color(hex: "#A9B0FF")],
                    startPoint: .trailing,
                    endPoint: .leading
                )
                .ignoresSafeArea()

                VStack(spacing: 30) {
                    Text("Welcome to Spark")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)

                    Spacer()
                    Spacer()

                    Text("What would you like to do?")
                        .font(.headline)
                        .foregroundColor(.white)

                    Button("Short Reflection") {
                        path.append(Screen.moodCheckIn)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color(hex: "#92B9FF"))
                    .cornerRadius(10)

                    Button("Daily Entry") {
                        path.append(Screen.moodCheckIn2)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color(hex: "#92B9FF"))
                    .cornerRadius(10)

                    Button("Log") {
                        path.append(Screen.historyCalendar)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color(hex: "#92B9FF"))
                    .cornerRadius(10)

                    Spacer()
                }
                .padding()
            }
            .navigationDestination(for: Screen.self) { screen in
                switch screen {
                case .moodCheckIn:
                    ContentView(path: $path)

                case .explanation(let mood):
                    ExplanationView(moodValue: mood, path: $path)

                case .suggestion(let text):
                    AISuggestionView(suggestion: text, path: $path)

                case .steps:
                    StepsView(path: $path)

                case .actionPlan(let suggestions):
                    ActionPlanView(suggestions: suggestions, path: $path)

                case .shortTermGoal:
                    ShortTermGoalView(path: $path)

                case .goalValidation(let message):
                    GoalValidationView(message: message, path: $path)

                case .moodCheckIn2:
                    Moodcheckin2(path: $path)

                case .journal(let moodValue):
                    JournalView(path: $path, moodValue: moodValue)
                        .environmentObject(dailyLogManager)

                case .goalSetting(let moodRating):
                    GoalSettingView(path: $path, moodRating: moodRating)
                        .environmentObject(goalManager)
                        .environmentObject(dailyLogManager)
                case .historyCalendar:
                    HistoryCalendarView(path: $path)
                        .environmentObject(dailyLogManager)
                }
            }
        }
    }
}

#Preview {
    MenuView()
        .environmentObject(GoalManager())
        .environmentObject(DailyLogManager())
}

