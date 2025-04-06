//
//  Screen.swift
//  SparkChallengeApp
//
//  Created by Prathyush Vasa on 4/6/25.
//


// Screen.swift
enum Screen: Hashable {
    case explanation(mood: Int)
    case suggestion(text: String)
    case steps
    case actionPlan(suggestions: [String])
    case shortTermGoal
    case goalValidation(message: String)
    case moodCheckIn
    case moodCheckIn2
    case journal
    case goalSetting
    case historyCalendar





}
