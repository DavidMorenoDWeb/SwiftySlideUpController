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
    
    // MARK: Properties
    
    static let identifier: String = "SlideUpDefaultTableViewCell"
    
    // MARK: Life-Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
