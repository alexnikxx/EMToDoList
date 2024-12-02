//
//  ListRouter.swift
//  EMToDoList
//
//  Created by Aleksandra Nikiforova on 16/11/24.
//

import UIKit

class ListRouter: ListRouterProtocol {
    weak var view: ListViewProtocol?

    init(viewController: ListViewProtocol) {
        self.view = viewController
    }

    func openTodoDetails(todo: CustomTodo) {
        let detailView = DetailViewController(todo: todo)
        view?.navigationController?.pushViewController(detailView, animated: true)
    }
    

}
