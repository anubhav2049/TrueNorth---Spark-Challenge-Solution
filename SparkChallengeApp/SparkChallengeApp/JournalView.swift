//
//  JournalView.swift
//  SparkChallengeApp
//
//  Created by Prathyush Vasa on 4/6/25.
//


import SwiftUI

struct JournalView: View {
    @Binding var path: NavigationPath
    @State private var dayReflection: String = ""
    @State private var emotionalReflection: String = ""
    @EnvironmentObject var dailyLogManager: DailyLogManager


    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("Daily Journal")
                    .font(.largeTitle)
                    .bold()

                Group {
                    Text("What happened today?")
                        .font(.headline)

                    TextEditor(text: $dayReflection)
                        .frame(height: 140)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                }

                Group {
                    Text("How are you feeling right now?")
                        .font(.headline)

                    TextEditor(text: $emotionalReflection)
                        .frame(height: 140)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                }

                Button("Submit") {
                    let today = Date()
                        dailyLogManager.saveEntry(
                            date: today,
                            journal: dayReflection,
                            feeling: emotionalReflection
                    )
                     // Go back to Menu or home after journal
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(12)
                
                
                Button("Continue") {
                    path.append(Screen.goalSetting)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)
                
                
                
                
            }
            .padding()
        }
        .background(
            LinearGradient(
                colors: [Color(hex: "#e0eafc"), Color(hex: "#cfdef3")],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )
        .navigationTitle("Journal")
    }
}
