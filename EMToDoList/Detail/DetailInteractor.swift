//
//  DetailInteractor.swift
//  EMToDoList
//
//  Created by Aleksandra Nikiforova on 30/11/24.
//

import Foundation

final class DetailInteractor: DetailInteractorProtocol {
    weak var presenter: DetailPresenterProtocol?
    let coreDataManager = CoreDataManager.shared

    init(presenter: DetailPresenterProtocol) {
        self.presenter = presenter
    }

    func saveTodo(todo: CustomTodo) {
        if coreDataManager.fetchTodos().contains(where: { $0.id == todo.id }) {
            coreDataManager.updateTodo(with: todo.id, title: todo.title, text: todo.text, isCompleted: todo.isCompleted)
        } else {
            coreDataManager.createTodo(id: todo.id, title: todo.title, text: todo.text, date: todo.date, isCompleted: todo.isCompleted)
        }
    }
}
