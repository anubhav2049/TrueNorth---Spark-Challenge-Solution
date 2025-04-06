//
//  DailyEntry.swift
//  SparkChallengeApp
//
//  Created by Prathyush Vasa on 4/6/25.
//


import Foundation


struct DailyEntry: Identifiable {
    let id = UUID()
    let date: Date
    var journal: String
    var feeling: String
    var goals: [Goal]
}
