//
//  GoalManager.swift
//  SparkChallengeApp
//
//  Created by Prathyush Vasa on 4/6/25.
//


import Foundation

class GoalManager: ObservableObject {
    @Published var goals: [Goal] = []

    func addGoal(title: String) {
        goals.append(Goal(title: title))
    }

    func toggleGoalCompletion(goal: Goal) {
        if let index = goals.firstIndex(of: goal) {
            goals[index].isCompleted.toggle()
        }
    }
}
