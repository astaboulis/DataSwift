//
//  DataSwiftAssignmentTests.swift
//  DataSwiftAssignmentTests
//
//  Created by Angelos Staboulis on 12/7/20.
//  Copyright © 2020 Angelos Staboulis. All rights reserved.
//

import XCTest
import Alamofire
import SwiftyJSON
@testable import DataSwiftAssignment

class DataSwiftAssignmentTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let expectation = self.expectation(description: "testing")
        let viewModel = TMDBViewModel()
        viewModel.fetchMovies(searchString: "comedy") { (array) in
            XCTAssert(array.count > 0)
            expectation.fulfill()
        }
        
      
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
