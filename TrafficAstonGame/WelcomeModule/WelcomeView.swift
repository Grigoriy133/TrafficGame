//
//  WelcomeView.swift
//  Traffic
//
//  Created by Гриша  on 11.12.2023.
//

import UIKit
import SnapKit

class WelcomeView: UIView {

    //MARK: - View
    var headImage = UIImageView()
    var heading = UILabel()
    var pickTitle = UILabel()
    var playerPicker = UIPickerView()
    var newGameButton = UIButton()
    var buttonStackView = UIStackView()
    var newPlayerButton = UIButton()
    var statisticButton = UIButton()
    let newPlayerAlertController = UIAlertController(title: "New player name", message: nil, preferredStyle: .alert)
    let checkUserAlertController = UIAlertController(title: "Error, please pick user or create new", message: nil, preferredStyle: .alert)
    var name = String()
    var settingButton = UIButton()

    
    //MARK: - LifeCycle
        init() {
            super.init(frame: .zero)
            createView()
            configurateViews()
            makeConstraints()
            configurateAlettController()
            configurateAlertControllerCheckUsersCount()
        }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    //MARK: - setupViewConfiguration
   private func createView(){
        addSubview(headImage)
        addSubview(heading)
        addSubview(pickTitle)
        addSubview(playerPicker)
       addSubview(buttonStackView)
       addSubview(newPlayerButton)
       addSubview(settingButton)
       buttonStackView.addSubview(newGameButton)
       buttonStackView.addSubview(statisticButton)
    }
   private func configurateViews(){
        backgroundColor = .black
        headImage.contentMode = .scaleAspectFit
        headImage.backgroundColor = UIColor(named: "white")
        
        heading.text = "Traffic Game"
        heading.textColor = .white
        heading.font = .systemFont(ofSize: 45)
       heading.textAlignment = .center
        
        pickTitle.text = "Who is going to play?"
        pickTitle.textColor = .white
        pickTitle.font = .systemFont(ofSize: 20)
       pickTitle.textAlignment = .center
        
       playerPicker.layer.cornerRadius = 10
       playerPicker.layer.borderWidth = 2
       playerPicker.layer.borderColor = UIColor.white.cgColor
        
        newPlayerButton.setTitle("New Player", for: .normal)
        newPlayerButton.layer.cornerRadius = 10
        newPlayerButton.layer.borderWidth = 2
        newPlayerButton.layer.borderColor = UIColor.white.cgColor
       
       buttonStackView.axis = .horizontal

       newGameButton.layer.cornerRadius = 15
       newGameButton.layer.borderWidth = 2
       newGameButton.layer.borderColor = UIColor.white.cgColor
      newGameButton.setImage(UIImage(systemName: "play"), for: .normal)
      newGameButton.tintColor = .white
       
       statisticButton.layer.cornerRadius = 15
       statisticButton.layer.borderWidth = 2
       statisticButton.layer.borderColor = UIColor.white.cgColor
       statisticButton.setImage(UIImage(systemName: "figure.stairs"), for: .normal)
       statisticButton.tintColor = .white
       
       settingButton.setTitle("Setting", for: .normal)
       settingButton.layer.cornerRadius = 10
       settingButton.layer.borderWidth = 2
       settingButton.layer.borderColor = UIColor.white.cgColor
       
    }
    
    private func configurateAlettController(){
       let actionAccept = UIAlertAction(title: "Accept", style: .default, handler: { _ in
           let userName = self.newPlayerAlertController.textFields?.first?.text ?? ""
           memoryServices.shared.updateDictionary(newUser: userName)
           self.playerPicker.reloadAllComponents()
        })
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel)
        newPlayerAlertController.addAction(actionAccept)
        newPlayerAlertController.addAction(actionCancel)
        newPlayerAlertController.addTextField { (textField) in
            textField.placeholder = "Name"
        }
    }
    private func configurateAlertControllerCheckUsersCount(){
    let actionCancel = UIAlertAction(title: "Ok", style: .cancel)
    self.checkUserAlertController.addAction(actionCancel)
    }
    private func makeConstraints(){
        headImage.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.height.equalToSuperview().multipliedBy(0.2)
            $0.right.left.equalToSuperview().inset(10)
        }
        heading.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(headImage.snp.bottom).offset(10)
            $0.right.left.equalToSuperview().inset(10)
        }
        pickTitle.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(heading.snp.bottom).offset(10)
            $0.right.left.equalToSuperview().inset(10)
        }
        playerPicker.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(pickTitle.snp.bottom).offset(40)
            $0.height.equalToSuperview().multipliedBy(0.1)
            $0.left.right.equalToSuperview().inset(10)
        }
        newPlayerButton.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(playerPicker.snp.bottom).offset(10)
            $0.right.left.equalToSuperview().inset(10)
            $0.height.equalToSuperview().multipliedBy(0.07)
        }
        buttonStackView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(settingButton.snp.bottom).offset(40)
            $0.height.equalToSuperview().dividedBy(7)
            $0.left.right.equalToSuperview()
        }
        newGameButton.snp.makeConstraints{
            $0.height.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.45)
            $0.left.equalToSuperview().inset(10)
        }
        statisticButton.snp.makeConstraints{
            $0.height.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.45)
            $0.right.equalToSuperview().inset(10)
        }
        settingButton.snp.makeConstraints(){
            $0.centerX.equalToSuperview()
            $0.top.equalTo(newPlayerButton.snp.bottom).offset(10)
            $0.right.left.equalToSuperview().inset(10)
            $0.height.equalToSuperview().multipliedBy(0.07)
        }
    }
}
