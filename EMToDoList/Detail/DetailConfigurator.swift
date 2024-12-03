//
//  DetailConfigurator.swift
//  EMToDoList
//
//  Created by Aleksandra Nikiforova on 30/11/24.
//

import Foundation

final class DetailConfigurator: DetailConfiguratorProtocol {
    func configure(for viewController: DetailViewProtocol) {
        let presenter = DetailPresenter(view: viewController)
        let interactor = DetailInteractor(presenter: presenter)
        let router = DetailRouter(viewController: viewController)

        presenter.interactor = interactor
        presenter.router = router
        viewController.presenter = presenter
    }
}
