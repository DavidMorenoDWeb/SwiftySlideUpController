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
    
    /// Determines if the current orientation is portrait
    private var portraitOrientation: Bool {
        return UIDevice.current.orientation == .portrait || UIDevice.current.orientation == .faceUp || UIDevice.current.orientation == .faceDown || UIDevice.current.orientation == .portraitUpsideDown
    }
    
    // MARK: Life-Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSlideUpController()
        presenter?.reloadComments()
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        
        coordinator.animate(alongsideTransition: { context in
            
        }, completion: { [weak self] context in
            if let _self = self {
                if _self.portraitOrientation {
                    _self.slideUpController?.set(controllerHeight: 500)
                } else {
                    _self.slideUpController?.set(controllerHeight: _self.view.frame.height)
                }
            }
        })
    }
    
    // MARK: Private methods
    
    private func setupSlideUpController() {
        slideUpController = SlideUpControllerModule().buildDefault()
        
        slideUpController?.present(in: self)
        
        slideUpController?.set(headerTitle: "Comments")
        slideUpController?.set(mainColor: UIColor(red: 0.0/255.0, green: 150.0/255.0, blue: 255.0/255.0, alpha: 1.0))
    }
}

extension MainDefaultView: MainView {
    
    func display(_ comments: [Comment]) {
        for (index, comment) in comments.enumerated() {
            slideUpController?.addItem(SlideUpControllerItem(data: SlideUpControllerItemData(title: comment.user.username, text: comment.text, image: nil), value: index, handler: { item in
                
                print("Item \(index) tapped, with name: \(String(describing: item.data.title))")
            }))
        }
    }
    
}
