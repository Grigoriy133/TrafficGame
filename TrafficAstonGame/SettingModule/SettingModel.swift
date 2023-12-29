//
//  SettingModel.swift
//  TrafficAstonGame
//
//  Created by Гриша  on 24.12.2023.
//

import Foundation
import UIKit

class settingModel {
static let shared = settingModel()
    var colorArray = [UIColor.blue, UIColor.yellow, UIColor.white]
    var levelsArray = ["Easy", "Medium", "Hard"]
    var levelsDictionary = ["Easy" : TimeInterval(2),
                            "Medium" : TimeInterval(1.5),
                            "Hard" : TimeInterval(1)]
    var usersImageDictionary: [String: String]{
        get {
            UserDefaults.standard.dictionary(forKey: "imageDictionary") as? [String: String] ?? [:]
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "imageDictionary")
            print(usersImageDictionary)
        }
    }

}

