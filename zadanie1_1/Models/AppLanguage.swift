//
//  AppLanguage.swift
//  zadanie1_1
//
//  Created by Вадим Сайко on 11.12.22.
//

import Foundation

class AppLanguage {
    static let APPLE_LANGUAGE_KEY = "AppleLanguages"
    static func currentLanguage() -> String {
        let userDef = UserDefaults.standard
        let languageArray = userDef.array(forKey: APPLE_LANGUAGE_KEY)
        var currentLanguage = languageArray?[0] as? String
        if let range = currentLanguage?.range(of: "-") {
            currentLanguage = String(currentLanguage![..<range.lowerBound])
        }
        return currentLanguage ?? "en"
    }
    static func setNewLanguage(_ language: String) {
        let userDef = UserDefaults.standard
        userDef.set([language, currentLanguage()], forKey: APPLE_LANGUAGE_KEY)
    }
}
