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

    var todos: [CustomTodo] = []

    init(presenter: ListPresenterProtocol) {
        self.presenter = presenter
    }

    func loadTodos() {
        //        if !UserDefaults.standard.didLoadJSON {

        networkService.fetchTodos { result in
            switch result {
            case .success(let todos):
                UserDefaults.standard.didLoadJSON = true
                self.presenter?.showData(todos: todos)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        //        } else {
        //            // core data
        //            print("Not the first time")
        //            return []
        //        }
    }

    func addTodo(todo: CustomTodo) {

    }

    func editTodo(todo: CustomTodo) {

    }

    func deleteTodo(todo: CustomTodo) {

    }
}
