//
//  Goal.swift
//  SparkChallengeApp
//
//  Created by Prathyush Vasa on 4/6/25.
//


import Foundation

struct Goal: Identifiable, Hashable {
    let id = UUID()
    var title: String
    var isCompleted: Bool = false
}
