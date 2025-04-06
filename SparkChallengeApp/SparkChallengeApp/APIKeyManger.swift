//
//  APIKeyManger.swift
//  SparkChallengeApp
//
//  Created by Prathyush Vasa on 4/6/25.
//

import Foundation

func loadAPIKey() -> String? {
    guard let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
          let dict = NSDictionary(contentsOfFile: path),
          let key = dict["OPENAI_API_KEY"] as? String else {
        print("❌ Could not load OpenAI API key.")
        return nil
    }
    return key
}
