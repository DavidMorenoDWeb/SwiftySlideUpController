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
        
        setupSlideUpController()
    }
    
    // MARK: Private methods
    
    private func setupSlideUpController() {
        slideUpController = SlideUpControllerModule().buildDefault()
        
        slideUpController?.present(in: self)
        
        slideUpController?.addItem(SlideUpControllerItem(data: SlideUpControllerItemData(title: "Title", text: "Subtitle is larger than the title", image: nil), value: 1, handler: { item in
            print("Item tapped!")
        }))
        
        slideUpController?.addItem(SlideUpControllerItem(data: SlideUpControllerItemData(title: "Title 2", text: "Subtitle is larger than the title and larger than the first text, because I want to check if the autolayout is correctly configured", image: nil), value: 2, handler: { item in
            print("Item tapped!")
        }))
        
        slideUpController?.addItem(SlideUpControllerItem(data: SlideUpControllerItemData(title: "Title 3", text: "Subtitle is larger than the title and larger than the first text", image: nil), value: 3, handler: { item in
            print("Item tapped!")
        }))
        
        slideUpController?.addItem(SlideUpControllerItem(data: SlideUpControllerItemData(title: "Title 4", text: "Subtitle is larger than the title and larger than the first text, because I want to check if the autolayout is correctly configured Subtitle is larger than the title and larger than the first text, because I want to check if the autolayout is correctly configured Subtitle is larger than the title and larger than the first text, because I want to check if the autolayout is correctly configured", image: nil), value: 3, handler: { item in
            print("Item tapped!")
        }))
        
        slideUpController?.addItem(SlideUpControllerItem(data: SlideUpControllerItemData(title: "Title 4", text: "Subtitle is larger than the title and larger than the first text, because I want to check if the autolayout is correctly configured Subtitle is larger than the title and larger than the first text, because I want to check if the autolayout is correctly configured Subtitle is larger than the title and larger than the first text, because I want to check if the autolayout is correctly configured", image: nil), value: 3, handler: { item in
            print("Item tapped!")
        }))
        
        slideUpController?.addItem(SlideUpControllerItem(data: SlideUpControllerItemData(title: "Title 4", text: "Subtitle is larger than the title and larger than the first text, because I want to check if the autolayout is correctly configured Subtitle is larger than the title and larger than the first text, because I want to check if the autolayout is correctly configured Subtitle is larger than the title and larger than the first text, because I want to check if the autolayout is correctly configured", image: nil), value: 3, handler: { item in
            print("Item tapped!")
        }))
        
        slideUpController?.addItem(SlideUpControllerItem(data: SlideUpControllerItemData(title: "Title 4", text: "Subtitle is larger than the title and larger than the first text, because I want to check if the autolayout is correctly configured Subtitle is larger than the title and larger than the first text, because I want to check if the autolayout is correctly configured Subtitle is larger than the title and larger than the first text, because I want to check if the autolayout is correctly configured", image: nil), value: 3, handler: { item in
            print("Item tapped!")
        }))
    }
}

extension MainDefaultView: MainView {

}
