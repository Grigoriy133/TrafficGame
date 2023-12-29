//
//  GameSettings.swift
//  Traffic
//
//  Created by Гриша  on 24.11.2023.
//

import Foundation
import UIKit

class GameSettings {
    static let shared = GameSettings()
    var gameLevel = TimeInterval(2)
    var currentUser = String("noname")
    var currentColor = UIColor.white
    
    let keyColor = "keyColor"
    let keyLevel = "keyLevel"
}
