//
//  SlideUpControllerModule.swift
//  SwiftySlideUpController
//
//  Created by David Moreno Lora on 16/04/2019.
//  Copyright © 2019 David Moreno Lora. All rights reserved.
//

import Foundation
import UIKit

open class SlideUpControllerModule {
    
    func buildDefault() -> UIViewController {
        let view = SlideUpControllerDefaultView()
        let presenter = SlideUpControllerDefaultPresenter()
        
        view.presenter = presenter
        presenter.view = view
        
        return view
    }
}
