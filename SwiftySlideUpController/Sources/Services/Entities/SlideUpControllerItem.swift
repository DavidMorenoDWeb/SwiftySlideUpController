//
//  SlideUpControllerItem.swift
//  SwiftySlideUpController
//
//  Created by David Moreno Lora on 17/04/2019.
//  Copyright © 2019 David Moreno Lora. All rights reserved.
//

import Foundation

open class SlideUpControllerItem<T> {
    
    public var data: SlideUpControllerItemData
    public var value: T?
    public var handler: ((SlideUpControllerItem<T>) -> Void)?
    
    public init(data: SlideUpControllerItemData, value: T?, handler: ((SlideUpControllerItem<T>) -> Void)?) {
        self.data = data
        self.value = value
        self.handler = handler
    }
}
