//
//  DetailProtocols.swift
//  EMToDoList
//
//  Created by Aleksandra Nikiforova on 30/11/24.
//

import Foundation

protocol DetailConfiguratorProtocol: AnyObject {
    func configure(for viewController: DetailViewProtocol)
}

protocol DetailViewProtocol: AnyObject {
    var presenter: DetailPresenterProtocol? { get set }

}

protocol DetailInteractorProtocol: AnyObject {
    var presenter: DetailPresenterProtocol? { get set } // weak

    func saveTodo(todo: CustomTodo)
    func editTodo(todo: CustomTodo)
}

protocol DetailPresenterProtocol: AnyObject {
    var router: DetailRouterProtocol? { get set }
    var interactor: DetailInteractorProtocol? { get set }
    var view: DetailViewProtocol? { get set } // weak

    func buttonSaveTapped()
    func buttonBackTapped()
}

protocol DetailRouterProtocol: AnyObject {
    var view: DetailViewProtocol? { get set } // weak
}
