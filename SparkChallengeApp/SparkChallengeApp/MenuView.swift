//
//  MenuView.swift
//  SparkChallengeApp
//
//  Created by Prathyush Vasa on 4/6/25.
//


import SwiftUI

struct MenuView: View {
    @State private var path = NavigationPath()
    @EnvironmentObject var dailyLogManager: DailyLogManager

    var body: some View {
        NavigationStack(path: $path) {
            ZStack{
                LinearGradient(
                    colors: [Color(hex:"#13535B"), Color(hex:"#2B0000")],
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
                    .cornerRadius(10)
                    .background(
                        LinearGradient(
                                    colors: [Color(hex: "#000057"), Color(hex: "#8F006A")],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                    
                    Button("Daily Entry") {
                        path.append(Screen.moodCheckIn2)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .background(
                        LinearGradient(
                                    colors: [Color(hex: "#000057"), Color(hex: "#8F006A")],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                    
                    Button("Log") {
                        path.append(Screen.historyCalendar)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .background(
                        LinearGradient(
                                    colors: [Color(hex: "#000057"), Color(hex: "#8F006A")],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                    
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
                case .journal:
                    JournalView(path: $path)
                        .environmentObject(dailyLogManager)
                case .goalSetting:
                    GoalSettingView(path: $path)
                        .environmentObject(GoalManager()) // inject manager
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
        .environmentObject(GoalManager())         //
        .environmentObject(DailyLogManager())
}
