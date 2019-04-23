//
//  MainDefaultBuilder.swift
//  Main
//
//  Created by David Moreno on 17/4/19.
//

import Foundation
import UIKit

class MainModule {

    func buildDefault() -> UIViewController {
        let view = MainDefaultView()
        let interactor = MainDefaultInteractor(commentsService: CommentsService())
        let presenter = MainDefaultPresenter()
        let router = MainDefaultRouter()

        view.presenter = presenter

        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router

        interactor.presenter = presenter

        router.presenter = presenter
        router.viewController = view
        
        return view
    }
}
