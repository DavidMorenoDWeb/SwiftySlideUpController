//
//  SlideUpControllerModule.swift
//  SwiftySlideUpController
//
//  Created by David Moreno Lora on 16/04/2019.
//  Copyright © 2019 David Moreno Lora. All rights reserved.
//

import Foundation

open class SlideUpControllerModule {
    
    // MARK: Initializers
    
    public init () {}
    
    // MARK: Build methods
    
    /// Creates SlideUpControllerDefaultView and links it with a presenter
    ///
    /// - Returns: a SlideUpControllerDefaultView
    public func buildDefault() -> SlideUpControllerDefaultView {
        let view = SlideUpControllerDefaultView()
        let presenter = SlideUpControllerDefaultPresenter()
        
        view.presenter = presenter
        presenter.view = view
        
        return view
    }
}
