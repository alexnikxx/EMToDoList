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

    init(presenter: ListPresenterProtocol) {
        self.presenter = presenter
    }

    func loadTodos() -> [CustomTodo] {
        if !UserDefaults.standard.didLoadJSON {
            networkService.fetchTodos()
            let todoList = networkService.createCustomTodos()
            UserDefaults.standard.didLoadJSON = true
            return todoList
        } else {
            // core data
            print("Not the first time")
            return []
        }
    }

    func addTodo(todo: CustomTodo) {

    }
    
    func editTodo(todo: CustomTodo) {

    }
    
    func deleteTodo(todo: CustomTodo) {
        
    }
}
