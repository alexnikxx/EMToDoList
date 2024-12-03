//
//  UserDefaults+Extension.swift
//  EMToDoList
//
//  Created by Aleksandra Nikiforova on 20/11/24.
//

import Foundation

extension UserDefaults {
    private enum UserDefaultsKeys: String {
        case isFirstLaunch
    }

    var didLoadJSON: Bool {
        get {
            bool(forKey: UserDefaultsKeys.isFirstLaunch.rawValue)
        }

        set {
            setValue(newValue, forKey: UserDefaultsKeys.isFirstLaunch.rawValue)
        }
    }
}
