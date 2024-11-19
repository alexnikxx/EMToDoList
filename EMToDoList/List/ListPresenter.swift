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
    
    func todoTapped(todo: Todo) {

    }
    
    func editTodoButtonTapped(todo: Todo) {

    }
    
    func deleteTodoButtonTapped(todo: Todo) {
        
    }
    
    func searchButtonTapped() {
        
    }
    

}
