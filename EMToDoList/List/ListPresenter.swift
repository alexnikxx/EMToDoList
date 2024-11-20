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

    func newTodoButtonTapped() {

    }
    
    func todoTapped(todo: CustomTodo) {

    }
    
    func editTodoButtonTapped(todo: CustomTodo) {

    }
    
    func deleteTodoButtonTapped(todo: CustomTodo) {
        
    }
    
    func searchButtonTapped() {
        
    }

    func appRuns() -> [CustomTodo] {
        guard let todos = interactor?.loadTodos() else {
            print("Interactor doesn't exist")
            return []
        }

        return todos
    }
}
