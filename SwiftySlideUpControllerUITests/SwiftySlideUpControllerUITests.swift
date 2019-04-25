//
//  SwiftySlideUpControllerUITests.swift
//  SwiftySlideUpControllerUITests
//
//  Created by David Moreno Lora on 25/04/2019.
//  Copyright © 2019 David Moreno Lora. All rights reserved.
//

import XCTest

class SwiftySlideUpControllerUITests: XCTestCase {

    func testTableViewNumberOfRows() {
        
        let app = XCUIApplication()
        app.launch()
        
        XCTAssertEqual(app.tables.element(boundBy: 0).cells.count, 6)
    }

}
