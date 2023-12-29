//
//  SettingView.swift
//  TrafficAstonGame
//
//  Created by Гриша  on 24.12.2023.
//

import UIKit

class SettingView: UIView {
    //MARK: Views
    let userNameLabel = UILabel()
    let userPhoto = UIImageView()
    let gameLevelLabel = UILabel()
    let gameLevelTitleLabel = UILabel()
    let downButton = UIButton()
    let upButton = UIButton()
    let carColorTitleLabel = UILabel()
    let carView = UIView()
    let leftButton = UIButton()
    let rightButton = UIButton()
    
    //MARK: - LifeCycle
        init() {
            super.init(frame: .zero)
            settupViews()
            configureViews()
            makeConstraints()
        }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    //MARK: - setupViewConfiguration
    private func settupViews(){
        addSubview(userNameLabel)
        addSubview(userPhoto)
        addSubview(gameLevelLabel)
        addSubview(gameLevelTitleLabel)
        addSubview(downButton)
        addSubview(upButton)
        addSubview(carColorTitleLabel)
        addSubview(carView)
        addSubview(leftButton)
        addSubview(rightButton)
    }
    
    private func configureViews(){
        backgroundColor = .black
        
        userNameLabel.textColor = .white
        userNameLabel.text = "hjdsbfeliwr"
        userNameLabel.font = .systemFont(ofSize: 30)
        
        userPhoto.image = UIImage(named: "1")
        userPhoto.contentMode = .scaleAspectFill
        userPhoto.layer.borderWidth = 2
        userPhoto.layer.borderColor = UIColor.white.cgColor
        userPhoto.clipsToBounds = true
        userPhoto.layer.masksToBounds = true
        userPhoto.layer.cornerRadius = 20
      

        gameLevelTitleLabel.text = "Select game level"
        gameLevelTitleLabel.textColor = .white
        gameLevelTitleLabel.font = .systemFont(ofSize: 30)
        gameLevelTitleLabel.textAlignment = .center
        
        gameLevelLabel.text = "hard"
        gameLevelLabel.textColor = .white
        gameLevelLabel.font = .systemFont(ofSize: 30)
        gameLevelLabel.textAlignment = .center
        
        upButton.setImage(UIImage(systemName: "arrowtriangle.up"), for: .normal)
        downButton.setImage(UIImage(systemName: "arrowtriangle.down"), for: .normal)
        upButton.tintColor = .white
        downButton.tintColor = .white
        upButton.layer.cornerRadius = 10
        downButton.layer.cornerRadius = 10
        upButton.layer.borderWidth = 2
        upButton.layer.borderColor = UIColor.white.cgColor
        downButton.layer.borderWidth = 2
        downButton.layer.borderColor = UIColor.white.cgColor
        
        carColorTitleLabel.textColor = .white
        carColorTitleLabel.text = "Select Car Color"
        carColorTitleLabel.font = .systemFont(ofSize: 30)
        carColorTitleLabel.textAlignment = .center
        
        
        leftButton.setImage(UIImage(systemName: "arrowtriangle.up"), for: .normal)
        rightButton.setImage(UIImage(systemName: "arrowtriangle.down"), for: .normal)
        leftButton.tintColor = .white
        rightButton.tintColor = .white
        leftButton.layer.cornerRadius = 10
        rightButton.layer.cornerRadius = 10
        leftButton.layer.borderWidth = 2
        leftButton.layer.borderColor = UIColor.white.cgColor
        rightButton.layer.borderWidth = 2
        rightButton.layer.borderColor = UIColor.white.cgColor
        
        carView.backgroundColor = GameSettings.shared.currentColor
    }
    private func makeConstraints(){
        userPhoto.snp.makeConstraints(){
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).inset(16)
            $0.right.equalToSuperview().inset(16)
            $0.width.equalToSuperview().dividedBy(5)
            $0.height.equalTo(userPhoto.snp.width)
        }
        userNameLabel.snp.makeConstraints(){
            $0.centerY.equalTo(userPhoto.snp.centerY)
            $0.right.equalTo(userPhoto.snp.left).inset(16)
            $0.width.equalToSuperview().dividedBy(3)
            $0.height.equalToSuperview().dividedBy(10)
        }
        gameLevelTitleLabel.snp.makeConstraints(){
            $0.top.equalTo(userNameLabel.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
        }
        gameLevelLabel.snp.makeConstraints() {
            $0.top.equalTo(gameLevelTitleLabel.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().dividedBy(2)
        }
        upButton.snp.makeConstraints(){
            $0.height.equalTo(gameLevelLabel.snp.height)
            $0.width.equalToSuperview().dividedBy(4)
            $0.left.equalTo(gameLevelLabel.snp.right).inset(16)
            $0.centerY.equalTo(gameLevelLabel.snp.centerY)
        }
        downButton.snp.makeConstraints(){
            $0.height.equalTo(gameLevelLabel.snp.height)
            $0.width.equalToSuperview().dividedBy(4)
            $0.right.equalTo(gameLevelLabel.snp.left).inset(16)
            $0.centerY.equalTo(gameLevelLabel.snp.centerY)
        }
        carColorTitleLabel.snp.makeConstraints(){
            $0.top.equalTo(gameLevelLabel.snp.bottom).offset(32)
            $0.width.equalToSuperview().dividedBy(1.1)
            $0.centerX.equalToSuperview()
        }
        carView.snp.makeConstraints(){
            $0.top.equalTo(carColorTitleLabel.snp.bottom).offset(32)
            $0.width.equalToSuperview().dividedBy(6)
            $0.height.equalToSuperview().dividedBy(6)
            $0.centerX.equalToSuperview()
        }
        leftButton.snp.makeConstraints(){
            $0.height.equalTo(gameLevelLabel.snp.height)
            $0.width.equalToSuperview().dividedBy(4)
            $0.left.equalTo(gameLevelLabel.snp.right).inset(16)
            $0.centerY.equalTo(carView.snp.centerY)
        }
        rightButton.snp.makeConstraints(){
            $0.height.equalTo(gameLevelLabel.snp.height)
            $0.width.equalToSuperview().dividedBy(4)
            $0.right.equalTo(gameLevelLabel.snp.left).inset(16)
            $0.centerY.equalTo(carView.snp.centerY)
        }
        
    
    }

}
