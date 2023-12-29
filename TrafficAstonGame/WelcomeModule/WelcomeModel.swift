//
//  Model.swift
//  Traffic
//
//  Created by Гриша  on 11.12.2023.
//

import Foundation

 class player{
    static let shared = player()
    let playersKey = "key"
    var playersDictionary = [String: Int]()
    var keys = [String]()
}
