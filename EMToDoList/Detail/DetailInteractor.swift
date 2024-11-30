//
//  DetailInteractor.swift
//  EMToDoList
//
//  Created by Aleksandra Nikiforova on 30/11/24.
//

import Foundation

final class DetailInteractor: DetailInteractorProtocol {
    weak var presenter: DetailPresenterProtocol?

    init(presenter: DetailPresenterProtocol) {
        self.presenter = presenter
    }

    func saveTodo(todo: CustomTodo) {
        //
    }

    func editTodo(todo: CustomTodo) {
        //
    }
}
