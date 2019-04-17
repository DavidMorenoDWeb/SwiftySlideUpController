//
//  SlideUpControllerItemData.swift
//  SwiftySlideUpController
//
//  Created by David Moreno Lora on 17/04/2019.
//  Copyright © 2019 David Moreno Lora. All rights reserved.
//

import Foundation

open class SlideUpControllerItemData {
    
    public var title: String?
    public var text: String?
    public var image: UIImage?
    
    public init(title: String?, text: String?, image: UIImage?) {
        self.title = title
        self.text = text
        self.image = image
    }
}
