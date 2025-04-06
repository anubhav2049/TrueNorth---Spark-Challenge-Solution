//
//  DailyLogManager.swift
//  SparkChallengeApp
//
//  Created by Prathyush Vasa on 4/6/25.
//


import Foundation


import Foundation

class DailyLogManager: ObservableObject {
    @Published var entries: [Date: DailyEntry] = [:]

    func saveEntry(date: Date, journal: String, feeling: String, goals: [Goal] = []) {
        let cleanDate = Calendar.current.startOfDay(for: date)
        entries[cleanDate] = DailyEntry(
            date: cleanDate,
            journal: journal,
            feeling: feeling,
            goals: goals
        )
    }
}
