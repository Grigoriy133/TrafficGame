//
//  GameView.swift
//  TrafficAstonGame
//
//  Created by Гриша  on 15.12.2023.
//

import UIKit

class GameView: UIView {
//MARK: - View
    let stopButton = UIButton()
    let scoreLabel = UILabel()
    let topBarView = UIView()
    
//MARK: - LifeCycle
        init() {
            super.init(frame: .zero)
            configurateViews()
            makeConstraints()
        }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

//MARK: ConfigurateViews
    private func configurateViews(){
        addSubview(topBarView)
        topBarView.addSubview(scoreLabel)
        topBarView.addSubview(stopButton)
        
        topBarView.backgroundColor = .black
        topBarView.layer.borderColor = UIColor.white.cgColor
        topBarView.layer.cornerRadius = 15
        topBarView.layer.borderWidth = 2
        topBarView.layer.zPosition = 1000000
        
        stopButton.setTitle("Stop", for: .normal)
        stopButton.setTitleColor(.white, for: .normal)
        
        scoreLabel.textColor = .white
    }
    private func makeConstraints(){
        topBarView.snp.makeConstraints{
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.height.equalToSuperview().dividedBy(15)
            $0.left.right.equalToSuperview()
        }
        stopButton.snp.makeConstraints{
            $0.left.top.bottom.equalToSuperview().inset(16)
            $0.width.equalToSuperview().dividedBy(5)
        }
        scoreLabel.snp.makeConstraints{
            $0.right.top.bottom.equalToSuperview().inset(16)
            $0.width.equalToSuperview().dividedBy(5)
        }
    }
    
}
