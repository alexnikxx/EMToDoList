//
//  ListViewController.swift
//  EMToDoList
//
//  Created by Aleksandra Nikiforova on 16/11/24.
//

import UIKit

class ListViewController: UIViewController, ListViewProtocol {
    let configurator = ListConfigurator()
    var presenter: ListPresenterProtocol?

    private var list: [CustomTodo] = []
    private var filteredList: [CustomTodo] = []

    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .todoBlack
        tableView.allowsSelection = true
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

//    private var activityIndicator: UIActivityIndicatorView = {
//        let indicator = UIActivityIndicatorView(style: .large)
//        indicator.translatesAutoresizingMaskIntoConstraints = false
//        indicator.hidesWhenStopped = true
//        return indicator
//    }()

    private let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(for: self)

        setupView()
        setupSearchController()
//        setupActivityIndicator()
//
//        showLoadingIndicator()

        navigationController?.toolbar.isTranslucent = false
        navigationController?.setToolbarHidden(false, animated: false)
        navigationController?.toolbar.barTintColor = .todoGray
        navigationController?.toolbar.tintColor = .todoWhite

        tableView.delegate = self
        tableView.dataSource = self
    }

    func displayLoadedData(customTodos: [CustomTodo]) {
//        hideLoadingIndicator()
        self.list = customTodos
        tableView.reloadData()
    }

    @objc func actionTapped() {
        print("Action tapped")
    }

    @objc func settingsTapped() {
        print("Settings tapped")
    }

    override func viewWillAppear(_ animated: Bool) {
        presenter?.appStarts()

        navigationItem.title = "Задачи"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always

        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        let count = UILabel()
        count.text = "7 задач"
        count.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        count.textColor = .todoWhite
        let actionButton = UIBarButtonItem(customView: count)

        let settingsButton = UIBarButtonItem(title: nil, style: .plain, target: self, action: #selector(settingsTapped))
        settingsButton.image = UIImage(systemName: "square.and.pencil")
        settingsButton.tintColor = .todoYellow

        toolbarItems = [flexibleSpace, actionButton, flexibleSpace, settingsButton]
        setToolbarItems(toolbarItems, animated: false)
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

//    private func showLoadingIndicator() {
//        activityIndicator.startAnimating()
//    }
//
//    private func hideLoadingIndicator() {
//        activityIndicator.stopAnimating()
//    }
//
//    private func setupActivityIndicator() {
//        view.addSubview(activityIndicator)
//
//        NSLayoutConstraint.activate([
//            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ])
//    }
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
        cell.update(todo: todo)

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapEdit(recognizer:)))
        cell.checkbox.addGestureRecognizer(tapGestureRecognizer)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo = list[indexPath.row]
        let detailView = DetailViewController(todo: todo)
        navigationController?.pushViewController(detailView, animated: true)
    }

    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ -> UIMenu? in
            let edit = UIAction(title: "Редактировать", image: UIImage(named: "edit")) { _ in
                //edit
            }

            let export = UIAction(title: "Поделиться", image: UIImage(named: "export")) { _ in
                //share
            }

            let delete = UIAction(title: "Удалить", image: UIImage(named: "trash"), attributes: .destructive) { _ in
                self.list.remove(at: indexPath.row)
            }

            let menu = UIMenu(title: "", children: [edit, export, delete])

            return menu
        }
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
