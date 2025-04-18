//
//  Moodcheckin2.swift
//  SparkChallengeApp
//
//  Created by Prathyush Vasa on 4/6/25.
//

import SwiftUI

struct Moodcheckin2: View {
    @State private var moodValue: Int = 5
    @Binding var path: NavigationPath

    var body: some View {
        ZStack{
            LinearGradient(
                                colors: [Color(hex:"#82FF98"), Color(hex:"#FFB5AF")],
                                    startPoint: .trailing,
                                    endPoint: .leading
                                )
                                .ignoresSafeArea()


            
            
            VStack(spacing: 30) {
                Text("How are you feeling today?")
                    .font(.title2)
                    .   foregroundColor(.white)
                    .padding()
                
                Text("\(moodValue)")
                    .font(.system(size: 64))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                
                Slider(value: Binding(
                    get: { Double(self.moodValue) },
                    set: { self.moodValue = Int($0) }
                ), in: 1...10, step: 1)
                .padding(.horizontal)
                
                Button("Continue") {
                    path.append(Screen.journal(moodValue: moodValue))
                }

                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(hex: "#FF8B6C"))
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)
            }
            .padding()
            .navigationTitle("Daily Check-In")
        }
    }
}

