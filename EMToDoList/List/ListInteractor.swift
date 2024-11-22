//
//  ListInteractor.swift
//  EMToDoList
//
//  Created by Aleksandra Nikiforova on 16/11/24.
//

import Foundation

class ListInteractor: ListInteractorProtocol {
    weak var presenter: ListPresenterProtocol?
    var networkService = NetworkService()
    let coreDataManager = CoreDataManager.shared
    var todos: [CustomTodo] = []

    init(presenter: ListPresenterProtocol) {
        self.presenter = presenter
    }

    func loadTodos() {
        if !UserDefaults.standard.didLoadJSON {
            networkService.fetchTodos { [weak self] result in
                switch result {
                case .success(let todos):
                    UserDefaults.standard.didLoadJSON = true
                    DispatchQueue.main.async {
                        self?.presenter?.showData(todos: todos)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        } else {
            let todos = coreDataManager.fetchTodos()
            let customTodos = todos.compactMap { todo in
                CustomTodo(title: todo.title, text: todo.text, date: todo.date, isCompleted: todo.isCompleted)
            }
            self.presenter?.showData(todos: customTodos)
        }
    }

    func addTodo(todo: CustomTodo) {

    }

    func editTodo(todo: CustomTodo) {

    }

    func deleteTodo(todo: CustomTodo) {

    }
}
