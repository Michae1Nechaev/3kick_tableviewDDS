//
//  ViewController.swift
//  3Kick_tableview
//
//  Created by Нечаев Михаил on 11.02.2024.
//

import UIKit

struct ViewModel: Hashable & Sendable {
    var index: Int
    var selected: Bool
}

class ViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.allowsMultipleSelection = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = 8
        tableView.register(NMCell.self, forCellReuseIdentifier: cellId)
        return tableView
    }()
    
    lazy var dataSource = UITableViewDiffableDataSource<Int, ViewModel>(tableView: tableView) { tableView, indexPath, itemIdentifier in
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellId, for: indexPath) as? NMCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.textLabel?.text = "\(self.viewModels[indexPath.row].index)"
        cell.checkImageView.image = self.viewModels[indexPath.row].selected ? UIImage(systemName: "checkmark.circle") : nil
        return cell
    }
    
    private var viewModels = [ViewModel]()
    private let cellId = String(describing: NMCell.self)
    
    init() {
        for i in 0..<30 {
            self.viewModels.append(ViewModel(index: i, selected: false))
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 32),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, ViewModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModels, toSection: 0)
        dataSource.apply(snapshot)
        
        dataSource.defaultRowAnimation = .fade
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "Selection"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Shuffle", style: .plain, target: self, action: #selector(shuffleAction))
    }
    
    @objc
    func shuffleAction() {
        viewModels.shuffle()
        updateTable()
    }
    
    private func updateTable() {
        var snapshot = dataSource.snapshot()
        snapshot.deleteAllItems()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModels)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        tableView.cellForRow(at: indexPath)?.selectionStyle = .default
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModels[indexPath.row].selected = !viewModels[indexPath.row].selected
        
        guard viewModels[indexPath.row].selected else {
            updateTable()
            return
        }
        
        let vm = viewModels[indexPath.row]
        viewModels.remove(at: indexPath.row)
        viewModels.insert(vm, at: 0)
        
        var snapshot = dataSource.snapshot()
        snapshot.deleteAllItems()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModels)
        dataSource.apply(snapshot, animatingDifferences: true)
        
        tableView.cellForRow(at: indexPath)?.selectionStyle = .none
    }
    
}
