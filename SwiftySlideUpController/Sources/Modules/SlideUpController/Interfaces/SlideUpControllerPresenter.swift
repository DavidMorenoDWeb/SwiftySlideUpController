//
//  SlideUpControllerPresenter.swift
//  SwiftySlideUpController
//
//  Created by David Moreno Lora on 16/04/2019.
//  Copyright © 2019 David Moreno Lora. All rights reserved.
//

import Foundation

public protocol SlideUpControllerPresenter: class {
    
    // MARK: Properties
    
    var view: SlideUpControllerView? { get set }
    var items: [SlideUpControllerItem<Any>] { get set }
    
    // MARK: Methods
    
    func addItem(_ item:SlideUpControllerItem<Any>)
    func present(in vc: UIViewController)
}
