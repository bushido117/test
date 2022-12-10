//
//  Localizer.swift
//  zadanie1_1
//
//  Created by Вадим Сайко on 8.12.22.
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

class Localizer: NSObject {

    static func doSwizzling() {
        methodSwizzle(cls: Bundle.self, originalSelector: #selector(Bundle.localizedString(forKey:value:table:)), overrideSelector: #selector(Bundle.specialLocalizedString(forKey:value:table:)))
        }
    }

extension Bundle {
//    Подменный метод
    @objc func specialLocalizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        let currentLanguage = AppLanguage.currentLanguage()
        var bundle = Bundle()
        if let _path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj") {
            bundle = Bundle(path: _path) ?? bundle
        } else {
            if let _path = Bundle.main.path(forResource: "en", ofType: "lproj") {
                bundle = Bundle(path: _path) ?? bundle
            }
        }
        return (bundle.specialLocalizedString(forKey: key, value: value, table: tableName))
    }
}

func methodSwizzle(cls: AnyClass, originalSelector: Selector, overrideSelector: Selector) {
    guard let originalMethod: Method = class_getInstanceMethod(cls, originalSelector) else { return }
    guard let overrideMethod: Method = class_getInstanceMethod(cls, overrideSelector)else { return }
    if (class_addMethod(cls, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
        class_replaceMethod(cls, overrideSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, overrideMethod);
    }
}
