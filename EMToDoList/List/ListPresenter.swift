//
//  ListPresenter.swift
//  EMToDoList
//
//  Created by Aleksandra Nikiforova on 16/11/24.
//

import Foundation

class ListPresenter: ListPresenterProtocol {
    var router: ListRouterProtocol?
    var interactor: ListInteractorProtocol?
    weak var view: ListViewProtocol?
    
    init(view: ListViewProtocol) {
        self.view = view
    }

    func viewWillAppear() {
        interactor?.loadTodos()
    }

    func updateTodos(todos: [CustomTodo]) {
        view?.displayLoadedData(customTodos: todos)
    }

    func didLoadTodos(todos: [CustomTodo]) {
        view?.displayLoadedData(customTodos: todos)
    }

    func newTodoButtonTapped() {
        router?.openTodoDetails(todo: CustomTodo(title: "", date: Date(), isCompleted: false))
    }

    func updateStatus(of todo: CustomTodo) {
        interactor?.editTodo(todo: todo)
    }

    func editTodoButtonTapped(todo: CustomTodo) {
        router?.openTodoDetails(todo: todo)
    }
    
    func deleteTodoButtonTapped(todo: CustomTodo) {
        interactor?.deleteTodo(todo: todo)
    }
}
