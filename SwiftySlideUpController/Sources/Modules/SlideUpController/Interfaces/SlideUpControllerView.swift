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
    
    func present(in vc: UIViewController)
    
}
