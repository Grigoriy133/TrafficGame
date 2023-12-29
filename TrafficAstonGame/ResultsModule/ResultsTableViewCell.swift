//
//  ResultsTableViewCell.swift
//  TrafficAstonGame
//
//  Created by Гриша  on 24.12.2023.
//

import UIKit
import SnapKit

class ResultsTableViewCell: UITableViewCell {
    static let identifier = "ResultsTableViewCell"
    let userNameLabel = UILabel()
    let userResultsLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupViews()
            configureViews()
            makeConstraints()
        }
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews(){
        addSubview(userNameLabel)
        addSubview(userResultsLabel)
    }
    func configureViews(){
        userNameLabel.textColor = .white
        userResultsLabel.textColor = .white
    }
    func makeConstraints(){
        userNameLabel.snp.makeConstraints(){
            $0.left.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.width.equalToSuperview().dividedBy(2)
            $0.height.equalToSuperview().multipliedBy(0.8)
        }
        userResultsLabel.snp.makeConstraints(){
            $0.right.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.width.equalToSuperview().dividedBy(2)
            $0.height.equalToSuperview().multipliedBy(0.8)
        }
    }
    func configure(with model: cellModel) {
        userNameLabel.text = "User name: " + model.userName
        userResultsLabel.text = "User best result: " + model.userResults
    }

}
