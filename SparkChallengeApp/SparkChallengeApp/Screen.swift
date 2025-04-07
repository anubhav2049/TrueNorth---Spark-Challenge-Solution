//
//  Screen.swift
//  SparkChallengeApp
//
//  Created by Prathyush Vasa on 4/6/25.
//


// Screen.swift
enum Screen: Hashable {
    case moodCheckIn
    case moodCheckIn2
    case explanation(mood: Int)
    case suggestion(text: String)
    case steps
    case actionPlan(suggestions: [String])
    case shortTermGoal
    case goalValidation(message: String)
    case journal(moodValue: Int)
    case goalSetting(moodRating: Int)
    case historyCalendar
}
