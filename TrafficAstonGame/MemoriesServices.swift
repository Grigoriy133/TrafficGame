//
//  MemoryServices.swift
//  Traffic
//
//  Created by Гриша  on 11.12.2023.
//

import Foundation
import UIKit

class memoryServices{
    static let shared = memoryServices()
    func updateDictionary(newUser: String){
        if checkName(name: newUser) {
            player.shared.playersDictionary[newUser] = 0
            updateResultsInformation()
            loadDictionary()
            print(player.shared.playersDictionary)
        } else {
            print("error")
        }
    }
    func loadDictionary(){
        if let playersDictionary = UserDefaults.standard.object(forKey: player.shared.playersKey) as? [String : Int] {
            player.shared.playersDictionary = playersDictionary
        }  else { }
        player.shared.keys = Array(player.shared.playersDictionary.keys)
    }
    func checkName(name: String) -> Bool {
        if player.shared.keys.contains(name) {
            return false
        } else {
            return true
        }
    }
    func updateResultsInformation(){
        UserDefaults.standard.set(player.shared.playersDictionary, forKey: player.shared.playersKey)
    }
    func saveLevel(_ levelValue: String){
        UserDefaults.standard.set(levelValue, forKey: GameSettings.shared.keyLevel)
        loadLevel()
    }
    func loadLevel(){
        if let level = UserDefaults.standard.object(forKey: GameSettings.shared.keyLevel) {
            if let levelString = level as? String {
                GameSettings.shared.gameLevel = settingModel.shared.levelsDictionary[levelString] ?? TimeInterval(2)
            }
        }
    }
    func saveColor(_ color: UIColor){
        let colorData = try? NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: false)
        UserDefaults.standard.set(colorData, forKey: GameSettings.shared.keyColor)
    }
    func loadColor(){
        if let colorData = UserDefaults.standard.object(forKey: GameSettings.shared.keyColor) as? Data {
            let color = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData)
            GameSettings.shared.currentColor = color ?? UIColor.white
        }
    }
func saveImage(image: UIImage) {
            guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() 
    else { return }
            let fileManager = FileManager.default
            if let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
                let filePath = documentsDirectory.appendingPathComponent("\( GameSettings.shared.currentUser).png")
                do {
                    try data.write(to: filePath)
                    settingModel.shared.usersImageDictionary[GameSettings.shared.currentUser] = filePath.path
                } catch {
                }
            }
        }
    func loadImages() -> UIImage {
        var newImage = UIImage()
        let filePath = settingModel.shared.usersImageDictionary[GameSettings.shared.currentUser] ?? ""
        let fileURL = URL(fileURLWithPath: filePath)
        print(fileURL)
        if let imageData = try? Data(contentsOf: fileURL) {
            let image = UIImage(data: imageData)
            newImage = image ?? UIImage()
        }
        return newImage
       }

}
