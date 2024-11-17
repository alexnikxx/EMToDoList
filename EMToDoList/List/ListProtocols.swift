//
//  ListProtocols.swift
//  EMToDoList
//
//  Created by Aleksandra Nikiforova on 16/11/24.
//

import Foundation

protocol ListConfiguratorProtocol: AnyObject {
    func configure(for viewController: ListViewProtocol)
}

protocol ListViewProtocol: AnyObject {
    var presenter: ListPresenterProtocol? { get set }

}

protocol ListInteractorProtocol: AnyObject {
    var presenter: ListPresenterProtocol? { get set } // weak

    func addTodo(todo: Todo)
    func editTodo(todo: Todo)
    func deleteTodo(todo: Todo)
}

protocol ListPresenterProtocol: AnyObject {
    var router: ListRouterProtocol? { get set }
    var interactor: ListInteractorProtocol? { get set }
    var view: ListViewProtocol? { get set } // weak

    func newTodoButtonTapped()
    func todoTapped(todo: Todo)
    func editTodoButtonTapped(todo: Todo)
    func deleteTodoButtonTapped(todo: Todo)
    func searchButtonTapped()
}

protocol ListRouterProtocol: AnyObject {
    var view: ListViewProtocol? { get set } // weak

    func openTodoDetails(todo: Todo)
}
