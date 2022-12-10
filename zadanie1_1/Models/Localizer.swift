//
//  Localizer.swift
//  zadanie1_1
//
//  Created by Вадим Сайко on 8.12.22.
//

import Foundation

class Localizer: NSObject {
    static func doSwizzling() {
        Swizzle.methodSwizzle(cls: Bundle.self, originalSelector: #selector(Bundle.localizedString(forKey:value:table:)), overrideSelector: #selector(Bundle.specialLocalizedString(forKey:value:table:)))
    }
}

class Swizzle {
    static func methodSwizzle(cls: AnyClass, originalSelector: Selector, overrideSelector: Selector) {
        guard let originalMethod: Method = class_getInstanceMethod(cls, originalSelector) else { return }
        guard let overrideMethod: Method = class_getInstanceMethod(cls, overrideSelector)else { return }
        if (class_addMethod(cls, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
            class_replaceMethod(cls, overrideSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, overrideMethod);
        }
    }
}

extension Bundle {
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
