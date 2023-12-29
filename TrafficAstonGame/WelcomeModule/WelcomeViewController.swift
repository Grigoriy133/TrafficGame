//
//  WelcomeViewController.swift
//  Traffic
//
//  Created by Гриша  on 11.12.2023.
//

import UIKit

class WelcomeViewController: UIViewController {
    //MARK: - Props
    let welcomeView = WelcomeView()
    let gameVC = CollisionExampleViewController()
    let resultsVC = ResultsViewController()
    let settingVC = SettingViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = welcomeView
        memoryServices.shared.loadDictionary()
        memoryServices.shared.loadLevel()
    }
    override func viewDidAppear(_ animated: Bool) {
        welcomeView.playerPicker.delegate = self
        welcomeView.playerPicker.dataSource = self
        configurateButtons()
        loaduser()
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        welcomeView.playerPicker.selectRow(setCurrentUser(), inComponent: 0, animated: false)
        memoryServices.shared.loadColor()
    }
    private func setCurrentUser() -> Int{
        var i = 0
        for user in player.shared.keys {
            if user == GameSettings.shared.currentUser {
                return i
            } else {
                i += 1
            }
        }
        return i
    }
    //MARK: - Private Functions
    private func configurateButtons(){
        welcomeView.newGameButton.addTarget(self, action: #selector(toPlay), for: .touchUpInside)
        welcomeView.newPlayerButton.addTarget(self, action: #selector(presentAlert), for: .touchUpInside)
        welcomeView.statisticButton.addTarget(self, action: #selector(toResults), for: .touchUpInside)
        welcomeView.settingButton.addTarget(self, action: #selector(toSettings), for: .touchUpInside)
    }
    @objc func toPlay(){
        if player.shared.keys.count > 0 {
            GameSettings.shared.currentUser = player.shared.keys[ welcomeView.playerPicker.selectedRow(inComponent: 0)]
            navigationController?.pushViewController(gameVC, animated: true) } else {
                present(welcomeView.checkUserAlertController,  animated: true, completion: nil)
            }
    }
    @objc func presentAlert(){
        present(welcomeView.newPlayerAlertController, animated: true, completion: nil)
    }
    @objc func toResults(){
        navigationController?.pushViewController(resultsVC, animated: true)
    }
    @objc func toSettings(){
        navigationController?.pushViewController(settingVC, animated: true)
    }
}
//MARK: Extension Delegate DataSource
extension WelcomeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return player.shared.playersDictionary.count
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let title = player.shared.keys[row]
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 18)
        ]
        return NSAttributedString(string: title, attributes: attributes)
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        GameSettings.shared.currentUser = player.shared.keys[row]
    }
    func loaduser(){
        if player.shared.keys.count != 0 {
            GameSettings.shared.currentUser = player.shared.keys[welcomeView.playerPicker.selectedRow(inComponent: 0)] }
    }
}
