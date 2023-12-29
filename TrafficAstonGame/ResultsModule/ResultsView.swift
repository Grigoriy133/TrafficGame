//
//  ResultsView.swift
//  TrafficAstonGame
//
//  Created by Гриша  on 24.12.2023.
//
import SnapKit
import UIKit

class ResultsView: UIView {
    
    var resultsTableView = UITableView()

    //MARK: - LifeCycle
        init() {
            super.init(frame: .zero)
            setupView()
            createConstraints()
        }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    private func setupView(){
        addSubview(resultsTableView)
        resultsTableView.backgroundColor = .black
    }
    private func createConstraints(){
        resultsTableView.snp.makeConstraints(){
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
        }
    }
    
}
