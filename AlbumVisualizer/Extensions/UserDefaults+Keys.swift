//
//  UserDefaults+Keys.swift
//  AlbumVisualizer
//
//  Created by Valentin Mille on 7/15/22.
//

import Foundation

extension UserDefaults {
    enum Keys: String {
        case onBoardingHasBeenShown
    }

    var onBoardingHasBeenShown: Bool {
        get {
            UserDefaults.standard.bool(forKey: Keys.onBoardingHasBeenShown.rawValue)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.onBoardingHasBeenShown.rawValue)
        }
    }
}
