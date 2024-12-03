//
//  DetailRouter.swift
//  EMToDoList
//
//  Created by Aleksandra Nikiforova on 30/11/24.
//

import Foundation

final class DetailRouter: DetailRouterProtocol {
    weak var view: DetailViewProtocol?

    init(viewController: DetailViewProtocol) {
        self.view = viewController
    }
}
