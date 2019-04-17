//
//  MainDefaultView.swift
//  Main
//
//  Created by David Moreno on 17/4/19.
//

import Foundation
import UIKit
import SwiftySlideUpController

class MainDefaultView: UIViewController {
    
    // MARK: Properties
    
    var presenter: MainPresenter?
    var slideUpController: SlideUpControllerDefaultView?
    
    // MARK: Life-Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSlideUpController()
    }
    
    // MARK: Private methods
    
    private func addSlideUpController() {
        slideUpController = SlideUpControllerModule().buildDefault()
        slideUpController?.present(in: self)
    }
}

extension MainDefaultView: MainView {

}
