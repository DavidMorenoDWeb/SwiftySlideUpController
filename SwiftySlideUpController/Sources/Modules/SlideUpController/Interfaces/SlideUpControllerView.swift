//
//  SlideUpControllerView.swift
//  SwiftySlideUpController
//
//  Created by David Moreno Lora on 16/04/2019.
//  Copyright © 2019 David Moreno Lora. All rights reserved.
//

import Foundation
import UIKit

public protocol SlideUpControllerView: UIViewController {
    
    // MARK: Properties
    
    var presenter: SlideUpControllerPresenter? { get set }
    
    // MARK: Methods
    
    func addItem(_ item:SlideUpControllerItem<Any>)
    func present(in vc: UIViewController)
    func set(mainColor color: UIColor)
    func set(headerTitle title: String)
    func set(controllerHeight height: CGFloat)
    func mainColorSetted()
    func headerTitleSetted()
}
