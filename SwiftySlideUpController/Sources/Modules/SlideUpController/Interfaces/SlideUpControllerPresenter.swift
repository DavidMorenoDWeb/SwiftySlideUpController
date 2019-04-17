//
//  SlideUpControllerPresenter.swift
//  SwiftySlideUpController
//
//  Created by David Moreno Lora on 16/04/2019.
//  Copyright © 2019 David Moreno Lora. All rights reserved.
//

import Foundation

protocol SlideUpControllerPresenter: class {
    
    // MARK: Properties
    
    var view: SlideUpControllerView? { get set }
    
    // MARK: Methods
    
    func present(in vc: UIViewController)
    
}
