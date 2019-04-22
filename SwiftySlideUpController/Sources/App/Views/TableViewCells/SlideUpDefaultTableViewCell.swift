//
//  SlideUpDefaultTableViewCell.swift
//  SwiftySlideUpController
//
//  Created by David Moreno Lora on 17/04/2019.
//  Copyright © 2019 David Moreno Lora. All rights reserved.
//

import UIKit

class SlideUpDefaultTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemSubtitle: UILabel!
    @IBOutlet weak var imageWidthConstraint: NSLayoutConstraint!
    
    // MARK: Properties
    
    static let identifier: String = "SlideUpDefaultTableViewCell"
    let imageWidth: CGFloat = 45.0
    
    // MARK: Life-Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: Private methods
    
    private func setImage(_ image: UIImage?) {
        self.itemImageView.image = nil
        
        if let image = image {
            self.itemImageView.image = image
            self.imageWidthConstraint.constant = imageWidth
        } else {
            self.imageWidthConstraint.constant = 0.0
        }
    }
    
    // MARK: Public methods
    
    public func refresh(with itemData: SlideUpControllerItemData) {
        setImage(itemData.image)
        self.itemTitle.text = itemData.title
        self.itemSubtitle.text = itemData.text
    }
    
}
