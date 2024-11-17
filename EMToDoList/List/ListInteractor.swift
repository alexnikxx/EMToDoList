//
//  ListInteractor.swift
//  EMToDoList
//
//  Created by Aleksandra Nikiforova on 16/11/24.
//

import Foundation

class ListInteractor: ListInteractorProtocol {
    weak var presenter: ListPresenterProtocol?

    init(presenter: ListPresenterProtocol) {
        self.presenter = presenter
    }

    func addTodo(todo: Todo) {
        <#code#>
    }
    
    func editTodo(todo: Todo) {
        <#code#>
    }
    
    func deleteTodo(todo: Todo) {
        <#code#>
    }
    
    
}
