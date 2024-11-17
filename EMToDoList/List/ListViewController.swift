//
//  ListViewController.swift
//  EMToDoList
//
//  Created by Aleksandra Nikiforova on 16/11/24.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ListViewProtocol {
    var presenter: ListPresenterProtocol?
    var list: TodoList = .init(todos: [], total: 0, skip: 0, limit: 0)

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.addSubview(tableView)

        tableView.delegate = self
        tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.todos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}
