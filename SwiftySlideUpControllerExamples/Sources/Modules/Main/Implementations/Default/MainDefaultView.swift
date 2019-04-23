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
        presenter?.reloadComments()
    }
    
    // MARK: Private methods
    
    private func setupSlideUpController() {
        slideUpController = SlideUpControllerModule().buildDefault()
        
        slideUpController?.present(in: self)
        
        slideUpController?.setHeaderTitle("Comments")
        slideUpController?.setMainColor(UIColor(red: 0.0/255.0, green: 150.0/255.0, blue: 255.0/255.0, alpha: 1.0))
    }
}

extension MainDefaultView: MainView {
    
    func display(_ comments: [Comment]) {
        for (index, comment) in comments.enumerated() {
            slideUpController?.addItem(SlideUpControllerItem(data: SlideUpControllerItemData(title: comment.user.username, text: comment.text, image: nil), value: index, handler: { item in
                print("Item tapped!")
            }))
        }
    }
    
}
