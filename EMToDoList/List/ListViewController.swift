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

    //MARK: Main properties

    private var list: [CustomTodo] = []
    private var filteredList: [CustomTodo] = []

    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .todoBlack
        tableView.allowsSelection = true
        tableView.showsVerticalScrollIndicator = false
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    private var count: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        label.textColor = .todoWhite
        label.text = "0 задач"
        return label
    }()

    //MARK: Search controller properties

    private let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        let textField = searchController.searchBar.searchTextField
        textField.backgroundColor = .todoGray
        return searchController
    }()

    private var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }

    private var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }

    //MARK: Main functions

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(for: self)
        showLoadingIndicator()
        presenter?.appStarts()

        setupView()
        setupNavBarAndToolbar()
        setupSearchController()
        setupActivityIndicator()
    }

    func displayLoadedData(customTodos: [CustomTodo]) {
        hideLoadingIndicator()
        self.list = customTodos
        tableView.reloadData()
        count.text = "\(list.count) задач"
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always

        setupToolbar()
    }

    @objc func newTaskButtonTapped() {
        presenter?.newTodoButtonTapped()
    }

    //MARK: Setup view functions

    private func setupView() {
        navigationItem.title = "Задачи"
        view.backgroundColor = .todoBlack
        view.addSubview(tableView)

        tableView.delegate = self
        tableView.dataSource = self

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    private func setupNavBarAndToolbar() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .todoGray

        navigationController?.toolbar.isTranslucent = false
        navigationController?.setToolbarHidden(false, animated: false)
        navigationController?.toolbar.barTintColor = .todoGray
        navigationController?.toolbar.tintColor = .todoYellow
    }

    private func setupToolbar() {
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        let tasksCountLabel = UIBarButtonItem(customView: self.count)

        let newTaskButton = UIBarButtonItem(title: nil, style: .plain, target: self, action: #selector(newTaskButtonTapped))
        newTaskButton.image = UIImage(systemName: "square.and.pencil")

        toolbarItems = [flexibleSpace, tasksCountLabel, flexibleSpace, newTaskButton]
        setToolbarItems(toolbarItems, animated: false)
    }

    //MARK: Search Controller functions

    private func setupSearchController() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.automaticallyShowsSearchResultsController = true

        let searchBar = searchController.searchBar
        let audioImage = UIImage(systemName: "mic.fill")
        searchBar.setImage(audioImage, for: .bookmark, state: [.normal])
        searchBar.showsBookmarkButton = true
    }

    //MARK: Activity indicator functions

    private func showLoadingIndicator() {
        activityIndicator.startAnimating()
    }

    private func hideLoadingIndicator() {
        activityIndicator.stopAnimating()
    }

    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

//MARK: Search Results Updates

extension ListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        filterTodos(with: text)
    }

    private func filterTodos(with text: String) {
        filteredList = list.filter { (todo: CustomTodo) -> Bool in
            return todo.title.lowercased().contains(text.lowercased())
        }

        tableView.reloadData()
    }
}

//MARK: Setup Table View

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredList.count
        }

        return list.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell else {
            fatalError("The table view could not dequeue a custom cell.")
        }

        let todo: CustomTodo
        if isFiltering {
            todo = filteredList[indexPath.row]
        } else {
            todo = list[indexPath.row]
        }

        cell.update(todo: todo)

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapEdit(recognizer:)))
        cell.checkbox.addGestureRecognizer(tapGestureRecognizer)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo: CustomTodo
        if isFiltering {
            todo = filteredList[indexPath.row]
        } else {
            todo = list[indexPath.row]
        }

        let detailView = DetailViewController(todo: todo, saveTodo: { [weak self] updatedTodo in
            self?.list[indexPath.row] = updatedTodo
            self?.tableView.reloadData()
        })
        
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

            let delete = UIAction(title: "Удалить", image: UIImage(named: "trash"), attributes: .destructive) { [weak self] _ in
                guard let self = self else { return }

                let todo = self.list[indexPath.row]
                let index = indexPath.row
                self.list.remove(at: index)

                let indexPath = IndexPath(row: index, section: 0)
                tableView.deleteRows(at: [indexPath], with: .fade)
                self.presenter?.deleteTodoButtonTapped(todo: todo)

                self.count.text = "\(list.count) задач"
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
