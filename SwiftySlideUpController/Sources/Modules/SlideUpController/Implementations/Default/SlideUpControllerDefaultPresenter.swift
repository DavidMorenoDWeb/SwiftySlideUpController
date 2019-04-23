//
//  SlideUpControllerDefaultPresenter.swift
//  SwiftySlideUpController
//
//  Created by David Moreno Lora on 16/04/2019.
//  Copyright © 2019 David Moreno Lora. All rights reserved.
//

import Foundation

open class SlideUpControllerDefaultPresenter {
    
    // MARK: SlideUpControllerPresenter Properties
    
    weak public var view: SlideUpControllerView?
    public var items: [SlideUpControllerItem<Any>] = []
    public var mainColor: UIColor?
    public var headerTitle: String?
    
    // MARK: Methods
    
    func addSlideUpControllerView(to vc: UIViewController) {
        if let slideUpView = view?.view {
            slideUpView.frame = vc.view?.bounds ?? .zero
            vc.view?.addSubview(slideUpView)
        }
    }
}

extension SlideUpControllerDefaultPresenter: SlideUpControllerPresenter {
    
    public func addItem(_ item: SlideUpControllerItem<Any>) {
        items.append(item)
    }
    
    public func present(in vc: UIViewController) {
        addSlideUpControllerView(to: vc)
    }
    
    public func setMainColor(_ color: UIColor) {
        mainColor = color
        view?.mainColorSetted()
    }
    
    public func setHeaderTitle(_ title: String) {
        headerTitle = title
        view?.headerTitleSetted()
    }
}
