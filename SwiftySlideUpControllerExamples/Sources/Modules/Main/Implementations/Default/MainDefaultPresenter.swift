//
//  MainDefaultPresenter.swift
//  Main
//
//  Created by David Moreno on 17/4/19.
//

import Foundation

class MainDefaultPresenter {
    
    var router: MainRouter?
    var interactor: MainInteractor?
    weak var view: MainView?
}

extension MainDefaultPresenter: MainPresenter {

}
