//
//  FlashcardReviewTests.swift
//  FlashcardReviewTests
//
//  Created by C4Q on 2/12/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import XCTest
@testable import FlashcardReview

class FlashcardReviewTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCategoriesLoaded() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let categoriesVC = CategoriesTableViewController()
        XCTAssertEqual(categoriesVC.categories.count, 3, "There are 3 categories")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
