//
//  InstantPanGestureRecognizer.swift
//  SwiftySlideUpController
//
//  Created by David Moreno Lora on 16/04/2019.
//  Copyright © 2019 David Moreno Lora. All rights reserved.
//

import UIKit

/// A pan gesture that enters into the `began` state on touch down instead of waiting for a touches moved event.
class InstantPanGestureRecognizer: UIPanGestureRecognizer {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if (self.state == UIGestureRecognizer.State.began) { return }
        super.touchesBegan(touches, with: event)
        self.state = UIGestureRecognizer.State.began
    }
}
