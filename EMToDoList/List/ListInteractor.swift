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

    var todos: [CustomTodo] {
        let todos = coreDataManager.fetchTodos()
        let customTodos = todos.compactMap { todo in
            CustomTodo(id: todo.id, title: todo.title, text: todo.text, date: todo.date, isCompleted: todo.isCompleted)
        }
        return customTodos
    }

    init(presenter: ListPresenterProtocol) {
        self.presenter = presenter
    }

    func loadTodos() {
        if !UserDefaults.standard.didLoadJSON {
            loadTodosFromURL()
        } else {
            self.presenter?.didLoadTodos(todos: todos)
        }
    }

    func addTodo(todo: CustomTodo) {

    }

    func editTodo(todo: CustomTodo) {
        coreDataManager.updateTodo(with: todo.id, title: todo.title, text: todo.text, date: todo.date, isCompleted: todo.isCompleted)
        presenter?.updateTodos(todos: todos)
    }

    func deleteTodo(todo: CustomTodo) {
        coreDataManager.deleteTodo(with: todo.id)
        presenter?.updateTodos(todos: todos)
    }

    private func loadTodosFromURL() {
        networkService.fetchTodos { [weak self] result in
            switch result {
            case .success(let todos):
                UserDefaults.standard.didLoadJSON = true
                todos.forEach { todo in
                    self?.coreDataManager.createTodo(id: todo.id, title: todo.title, text: todo.text, date: todo.date, isCompleted: todo.isCompleted)
                }

                DispatchQueue.main.async {
                    self?.presenter?.didLoadTodos(todos: todos)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
