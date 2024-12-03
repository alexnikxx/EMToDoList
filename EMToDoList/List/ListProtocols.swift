//
//  ListProtocols.swift
//  EMToDoList
//
//  Created by Aleksandra Nikiforova on 16/11/24.
//

import Foundation
import UIKit

protocol ListConfiguratorProtocol: AnyObject {
    func configure(for viewController: ListViewProtocol)
}

protocol ListViewProtocol: AnyObject {
    var presenter: ListPresenterProtocol? { get set }
    var navigationController: UINavigationController? { get }

    func displayLoadedData(customTodos: [CustomTodo])
}

protocol ListInteractorProtocol: AnyObject {
    var presenter: ListPresenterProtocol? { get set } // weak

    func loadTodos()
    func editTodo(todo: CustomTodo)
    func deleteTodo(todo: CustomTodo)
}

protocol ListPresenterProtocol: AnyObject {
    var router: ListRouterProtocol? { get set }
    var interactor: ListInteractorProtocol? { get set }
    var view: ListViewProtocol? { get set } // weak

    func viewWillAppear()
    func didLoadTodos(todos: [CustomTodo])
    func updateTodos(todos: [CustomTodo])
    func newTodoButtonTapped()
    func updateStatus(of todo: CustomTodo)
    func editTodoButtonTapped(todo: CustomTodo)
    func deleteTodoButtonTapped(todo: CustomTodo)
}

protocol ListRouterProtocol: AnyObject {
    var view: ListViewProtocol? { get set } // weak

    func openTodoDetails(todo: CustomTodo)
}
