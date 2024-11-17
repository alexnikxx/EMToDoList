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
        <#code#>
    }
    
    func todoTapped(todo: Todo) {
        <#code#>
    }
    
    func editTodoButtonTapped(todo: Todo) {
        <#code#>
    }
    
    func deleteTodoButtonTapped(todo: Todo) {
        <#code#>
    }
    
    func searchButtonTapped() {
        <#code#>
    }
    

}
