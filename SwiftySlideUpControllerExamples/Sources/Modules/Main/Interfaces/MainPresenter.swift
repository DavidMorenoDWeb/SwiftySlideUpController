//
//  MainPresenter.swift
//  Main
//
//  Created by David Moreno on 17/4/19.
//

import Foundation

protocol MainPresenter: class {
    
    var router: MainRouter? { get set }
    var interactor: MainInteractor? { get set }
    var view: MainView? { get set }
    
    func reloadComments()
    
}
