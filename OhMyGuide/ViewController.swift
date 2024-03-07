//
//  ViewController.swift
//  OhMyGuide
//
//  Created by Anton Abramov on 06.03.2024.
//

import UIKit

private enum Constant {
    static let tableRowHeight: CGFloat = 100
}

final class ViewController: UIViewController {
    private let mainTableView = UITableView()
    private var cellDataSource = [[Int]]()
    
    let mockServer = RandomMockServer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        
        mockServer.subscribeToUpdates { [weak self] in
            guard let self else { return }
            if self.cellDataSource.isEmpty {
                self.cellDataSource = $0
                self.mainTableView.reloadData()
            } else {
                self.updateTableCell(with: $0)
            }
        }
    }
}

// MARK: - Private Methods

private extension ViewController {
    func updateTableCell(with dataSource: [[Int]]) {
        for (index, value) in dataSource.enumerated() {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = mainTableView.cellForRow(at: indexPath) as? MainTableViewCell {
                cell.updateItem(with: value)
            }
        }
    }
}

private extension ViewController {
    func configureTableView() {
        view.addSubview(mainTableView)
        mainTableView.showsVerticalScrollIndicator = false
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        registerTableCells()
        addConstraints()
    }
    
    func registerTableCells() {
        mainTableView.register(
            MainTableViewCell.self,
            forCellReuseIdentifier: MainTableViewCell.reuseIdentifire
        )
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            mainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainTableView.topAnchor.constraint(equalTo: view.topAnchor),
            mainTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTableView.dequeueReusableCell(
            withIdentifier: MainTableViewCell.reuseIdentifire,
            for: indexPath
        ) as! MainTableViewCell
        cell.configure(witn: cellDataSource[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constant.tableRowHeight
    }
}
