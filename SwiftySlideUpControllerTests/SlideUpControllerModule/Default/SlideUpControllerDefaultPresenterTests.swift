//
//  SlideUpControllerDefaultPresenterTests.swift
//  SwiftySlideUpControllerTests
//
//  Created by David Moreno Lora on 24/04/2019.
//  Copyright © 2019 David Moreno Lora. All rights reserved.
//

import XCTest
@testable import SwiftySlideUpController

class SlideUpControllerViewMock: UIViewController, SlideUpControllerView {
    
    var addItemCalled = false
    var presentCalled = false
    var setMainColorCalled = false
    var setHeaderTitleCalled = false
    var setControllerHeightCalled = false
    var mainColorSettedCalled = false
    var headerTitleSettedCalled = false
    var presenter: SlideUpControllerPresenter?
    
    func addItem(_ item: SlideUpControllerItem<Any>) {
        addItemCalled = true
    }
    
    func present(in vc: UIViewController) {
        presentCalled = true
    }
    
    func set(mainColor color: UIColor) {
        setMainColorCalled = true
    }
    
    func set(headerTitle title: String) {
        setHeaderTitleCalled = true
    }
    
    func set(controllerHeight height: CGFloat) {
        setControllerHeightCalled = true
    }
    
    func mainColorSetted() {
        mainColorSettedCalled = true
    }
    
    func headerTitleSetted() {
        headerTitleSettedCalled = true
    }
    
}

class SlideUpControllerDefaultPresenterTests: XCTestCase {

    var slideUpControllerViewMock: SlideUpControllerViewMock!
    
    override func setUp() {
        slideUpControllerViewMock = SlideUpControllerViewMock()
    }

    override func tearDown() {
        slideUpControllerViewMock = nil
    }
    
    func testShouldSetMainColor() {
        let presenterUnderTest = SlideUpControllerDefaultPresenter()
        presenterUnderTest.view = slideUpControllerViewMock
        presenterUnderTest.set(mainColor: UIColor.blue)
        
        XCTAssertTrue(slideUpControllerViewMock.mainColorSettedCalled)
    }
    
    func testShouldSetHeaderTitle() {
        let presenterUnderTest = SlideUpControllerDefaultPresenter()
        presenterUnderTest.view = slideUpControllerViewMock
        presenterUnderTest.set(headerTitle: "Opinions")
        
        XCTAssertTrue(slideUpControllerViewMock.headerTitleSettedCalled)
    }
    
    func testAddItem() {
        let presenterUnderTest = SlideUpControllerDefaultPresenter()
        
        presenterUnderTest.addItem(SlideUpControllerItem(data: SlideUpControllerItemData(title: "", text: "", image: nil), value: 1, handler: { item in
            
        }))
        
        XCTAssertEqual(presenterUnderTest.items.count, 1)
    }

}
