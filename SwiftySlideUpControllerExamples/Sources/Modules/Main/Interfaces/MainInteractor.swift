//
//  MainInteractor.swift
//  Main
//
//  Created by David Moreno on 17/4/19.
//

import Foundation

protocol MainInteractor {
    
    var presenter: MainPresenter? { get set }
    
    func comments() -> [Comment]
}
