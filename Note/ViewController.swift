//
//  ViewController.swift
//  Note
//
//  Created by Kirill  Kostenko  on 09.02.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.register(CustomHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "HeaderView")
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemYellow
        button.setTitle("Добавить заметку", for: .normal)
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(self.didTapButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var viewModel: [Post] = [
        Post(logo: "new logo")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupView()
     
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Заметки"
    }
    
    private func setupView() {
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.button)
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            self.button.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            self.button.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            self.button.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            self.button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as? CustomHeaderFooterView else { return nil }
            
            let viewModel = CustomHeaderFooterView.ViewModel(text: "Мои заметки")
            headerView.setup(with: viewModel)
            return headerView
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomTableViewCell else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
            return cell
        }
        
        let post = self.viewModel[indexPath.row]
        let viewModel = CustomTableViewCell.ViewModel(image: UIImage(systemName: "heart.fill"))
        cell.setup(with: viewModel)
        return cell
    }
    
    //    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {}
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        let photosViewController = CustomViewNote()
        //photosViewController.title = ""
        self.navigationController?.pushViewController(photosViewController, animated: true)}

//        let cell = self.tableView.cellForRow(at: indexPath) as? CustomTableViewCell
//        cell?.changeText("Hello, World!")
    
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Поделиться") { _, _, _ in
            
        }
        action.backgroundColor = .systemBlue
        
        let configuration = UISwipeActionsConfiguration(actions: [action])
        return configuration
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Удалить") { _, _, _ in
            self.viewModel.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .left)
        }
        let smthAction = UIContextualAction(style: .normal, title: "Добавить действие") { _, _, _ in
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [action, smthAction])
        return configuration
    }
    @objc private func didTapButton() {
        self.viewModel.insert(Post(logo: "new logo"), at: 0)
        self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .right)
        self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    
}
