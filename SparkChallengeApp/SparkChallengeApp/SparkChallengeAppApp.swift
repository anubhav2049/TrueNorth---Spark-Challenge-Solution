//
//  SparkChallengeAppApp.swift
//  SparkChallengeApp
//
//  Created by Prathyush Vasa on 4/5/25.
//

import SwiftUI

@main
struct SparkChallengeAppApp: App {
    @StateObject var goalManager = GoalManager()
    @StateObject var dailyLogManager = DailyLogManager()
    var body: some Scene {
        WindowGroup {
            MenuView()
                .environmentObject(goalManager)
                .environmentObject(DailyLogManager())
        }
    }
}
