//
//  CheckboxToggleStyle.swift
//  SparkChallengeApp
//
//  Created by Prathyush Vasa on 4/6/25.
//


import SwiftUI

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }) {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                    .foregroundColor(configuration.isOn ? .blue : .gray)
                    .imageScale(.large)
                configuration.label
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}
