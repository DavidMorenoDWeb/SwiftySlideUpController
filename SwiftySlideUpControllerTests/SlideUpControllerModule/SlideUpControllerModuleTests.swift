//
//  SlideUpControllerModuleTests.swift
//  SwiftySlideUpControllerTests
//
//  Created by David Moreno Lora on 24/04/2019.
//  Copyright © 2019 David Moreno Lora. All rights reserved.
//

import XCTest
@testable import SwiftySlideUpController

class SlideUpControllerModuleTests: XCTestCase {
    
    private var slideUpControllerDefault: SlideUpControllerDefaultView!

    override func setUp() {
        slideUpControllerDefault = SlideUpControllerModule().buildDefault()
    }

    override func tearDown() {
        slideUpControllerDefault = nil
    }
    
    func testSlideUpControllerDefaultExists() {
        XCTAssertFalse(slideUpControllerDefault == nil)
    }
    
    func testSlideUpControllerDefaultHasPresenter() {
        XCTAssertFalse(slideUpControllerDefault.presenter == nil)
    }
    
    func testSlideUpControllerDefaultPresenterHasView() {
        XCTAssertEqual(slideUpControllerDefault, slideUpControllerDefault.presenter?.view)
    }

}
