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
        super.init()
        setupTableView()
    }
    
    // MARK: Methods
    
    private func setupTableView() {
        let bundle = Bundle(for: type(of: self))
        self.slideUpController?.tableView.register(UINib(nibName: SlideUpDefaultTableViewCell.identifier, bundle: bundle), forCellReuseIdentifier: SlideUpDefaultTableViewCell.identifier)
        self.slideUpController?.tableView.dataSource = self
        self.slideUpController?.tableView.delegate = self
    }
}

// MARK: [Extension] - UITableViewDataSource

extension SlideUpDefaultItemHandler: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let slideUpController = slideUpController else {
            return 0
        }
        
        return slideUpController.presenter?.items.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SlideUpDefaultTableViewCell = tableView.dequeueReusableCell(withIdentifier: SlideUpDefaultTableViewCell.identifier) as! SlideUpDefaultTableViewCell
        
        if let itemData = slideUpController?.presenter?.items[indexPath.row].data {
            cell.refresh(with: itemData)
        }
        
        return cell
    }
    
}

// MARK: [Extension] - UITableViewDelegate

extension SlideUpDefaultItemHandler: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = slideUpController?.presenter?.items[indexPath.row] {
            
            item.handler?(item)
        }
    }
}
