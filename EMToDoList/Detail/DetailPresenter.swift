//
//  DetailPresenter.swift
//  EMToDoList
//
//  Created by Aleksandra Nikiforova on 30/11/24.
//

import Foundation

final class DetailPresenter: DetailPresenterProtocol {
    var router: DetailRouterProtocol?
    var interactor: DetailInteractorProtocol?
    weak var view: DetailViewProtocol?

    init(view: DetailViewProtocol) {
        self.view = view
    }

    func buttonSaveTapped(todo: CustomTodo) {
        interactor?.saveTodo(todo: todo)
    }

    func buttonBackTapped(todo: CustomTodo) {
        interactor?.saveTodo(todo: todo)
    }
}
