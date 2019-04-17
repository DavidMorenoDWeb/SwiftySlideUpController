//
//  SlideUpDefaultItemHandler.swift
//  SwiftySlideUpController
//
//  Created by David Moreno Lora on 17/04/2019.
//  Copyright © 2019 David Moreno Lora. All rights reserved.
//

import Foundation

open class SlideUpDefaultItemHandler: NSObject {
    
    // MARK: Properties
    
    private weak var slideUpController: SlideUpControllerDefaultView?
    
    // MARK: Initializers
    
    public init(slideUpController: SlideUpControllerDefaultView) {
        self.slideUpController = slideUpController
    }
}

// MARK: [Extension] - UITableViewDataSource

extension SlideUpDefaultItemHandler: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let slideUpController = slideUpController else {
            return 0
        }
        
        // TODO: slideUpController.presenter.items.count
        return 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SlideUpDefaultTableViewCell = tableView.dequeueReusableCell(withIdentifier: SlideUpDefaultTableViewCell.identifier) as! SlideUpDefaultTableViewCell
        
        // TODO: configProductCell(cell, atIndexPath: indexPath)
        
        return cell
    }
    
}
