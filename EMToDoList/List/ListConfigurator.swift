//
//  ListConfigurator.swift
//  EMToDoList
//
//  Created by Aleksandra Nikiforova on 16/11/24.
//

import Foundation

class ListConfigurator: ListConfiguratorProtocol {
    func configure(for viewController: ListViewProtocol) {
        let presenter = ListPresenter(view: viewController)
        let interactor = ListInteractor(presenter: presenter)
        let router = ListRouter(viewController: viewController)
        
        presenter.interactor = interactor
        presenter.router = router
        viewController.presenter = presenter
    }
}
