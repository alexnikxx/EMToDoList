//
//  ListViewController.swift
//  EMToDoList
//
//  Created by Aleksandra Nikiforova on 16/11/24.
//

import UIKit

class ListViewController: UIViewController, ListViewProtocol {
    var presenter: ListPresenterProtocol?
    var list: [CustomTodo] = CustomTodo.examples
    var filteredList: [CustomTodo] = []

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .todoBlack
        tableView.allowsSelection = true
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSearchController()

        navigationController?.isToolbarHidden = false
        navigationController?.setToolbarHidden(false, animated: false)
        navigationController?.toolbar.barTintColor = .todoBlack
        navigationController?.toolbar.tintColor = .todoWhite
        if let toolbar = navigationController?.toolbar {
            print("Toolbar frame: \(toolbar.frame)")
            print("Toolbar hidden: \(navigationController?.isToolbarHidden ?? true)")
        }

        tableView.delegate = self
        tableView.dataSource = self
    }

    @objc func actionTapped() {
        print("Action tapped")
    }

    @objc func settingsTapped() {
        print("Settings tapped")
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Задачи"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always

        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let actionButton = UIBarButtonItem(title: "Action", style: .plain, target: self, action: #selector(actionTapped))
        let settingsButton = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(settingsTapped))

        // Set toolbar items
        toolbarItems = [actionButton, flexibleSpace, settingsButton]
        setToolbarItems(toolbarItems, animated: false)
    }

    override func setToolbarItems(_ toolbarItems: [UIBarButtonItem]?, animated: Bool) {

    }

    private func setupView() {
        view.backgroundColor = .todoBlack
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search"

        navigationItem.searchController = searchController
        definesPresentationContext = false
        navigationItem.hidesSearchBarWhenScrolling = false

        let searchBar = searchController.searchBar
        searchBar.delegate = self
        let audioImage = UIImage(systemName: "mic.fill")
        searchBar.setImage(audioImage, for: .bookmark, state: [.normal])
        searchBar.showsBookmarkButton = true
    }

    func inSearchMode(_ searchController: UISearchController) -> Bool {
        let isActive = searchController.isActive
        let searchText = searchController.searchBar.text ?? ""

        return isActive && !searchText.isEmpty
    }

    func updateSearchController(searchBarText: String?) {
        if let searchText = searchBarText?.lowercased() {
            guard !searchText.isEmpty else { return }

            filteredList = list.filter({
                $0.title.lowercased().contains(searchText)
            })
        }
    }
}

extension ListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print(text)
    }

    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        print("Tapped!")
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell else {
            fatalError("The table view could not dequeue a custom cell.")
        }
        let todo = list[indexPath.row]
        cell.configure(todo: todo)

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapEdit(recognizer:)))
        cell.checkbox.addGestureRecognizer(tapGestureRecognizer)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo = list[indexPath.row]
        let detailView = DetailViewController(todo: todo)
        navigationController?.pushViewController(detailView, animated: true)
    }

    @objc func tapEdit(recognizer: UITapGestureRecognizer) {
        if recognizer.state == UIGestureRecognizer.State.ended {
            let tapLocation = recognizer.location(in: self.tableView)
            if let tapIndexPath = self.tableView.indexPathForRow(at: tapLocation) {
                if let tappedCell = self.tableView.cellForRow(at: tapIndexPath) as? ListTableViewCell {
                    var todo = list[tapIndexPath.row]
                    todo.isCompleted.toggle()
                    tappedCell.update(todo: todo)
                    list[tapIndexPath.row] = todo
                }
            }
        }
    }
}
