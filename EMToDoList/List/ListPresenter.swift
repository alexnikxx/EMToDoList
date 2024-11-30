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
    
    @objc func newTodoButtonTapped() {
        router?.openTodoDetails(todo: CustomTodo(title: "", date: Date(), isCompleted: false))
    }
    
    func todoTapped(todo: CustomTodo) {
        
    }
    
    func editTodoButtonTapped(todo: CustomTodo) {
        
    }
    
    func deleteTodoButtonTapped(todo: CustomTodo) {
        interactor?.deleteTodo(todo: todo)
    }

    func updateCount() {
//        view.updateCount()
    }

    func searchButtonTapped() {
        
    }
    
    func appStarts() {
        interactor?.loadTodos()
    }
    
    func showData(todos: [CustomTodo]) {
        self.view?.displayLoadedData(customTodos: todos)
    }
}
