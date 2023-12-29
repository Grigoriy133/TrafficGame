//
//  ResultsViewController.swift
//  TrafficAstonGame
//
//  Created by Гриша  on 24.12.2023.
//

import UIKit

class ResultsViewController: UIViewController {

    let resultsView = ResultsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = resultsView
    }
    override func viewWillAppear(_ animated: Bool) {
        resultsView.resultsTableView.reloadData()
        configureTableView()
        navigationController?.navigationBar.isHidden = false
    }
    private func configureTableView(){
        resultsView.resultsTableView.dataSource = self
        resultsView.resultsTableView.register(ResultsTableViewCell.self, forCellReuseIdentifier: ResultsTableViewCell.identifier)
    }
}
extension ResultsViewController:  UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        player.shared.keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ResultsTableViewCell.identifier, for: indexPath) as? ResultsTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: cellModel(userName: player.shared.keys[indexPath.row],
                                       userResults: String(player.shared.playersDictionary[player.shared.keys[indexPath.row]] ?? 0)))
        cell.backgroundColor = .black
        return cell
    }
    
    
}
