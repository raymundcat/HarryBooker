//
//  QueryTableErrorHandlingTest.swift
//  HarryBookerTests
//
//  Created by Raymund Catahay on 2021-01-26.
//

import XCTest
import CasePaths
import PromiseKit
import OHHTTPStubs
import OHHTTPStubsSwift
@testable import HarryBooker

class QueryTableErrorHandlingTest: StubbedTests {
    
    override class func setUp() {
        stub { (request) -> Bool in
            return request.url?.host == "api.storytel.net" &&
                request.url?.valueOf("query") == "Harry"
        } response: { (request) -> HTTPStubsResponse in
            let error = NSError(
                    domain: "test",
                    code: 500,
                    userInfo: [:])
            return HTTPStubsResponse(error: error)
        }
    }
    
    func testFirstOnLoadValue() {
        
        let presenter = QueryTablePresenter(query: "Harry")
        
        let bucket = PresentableBucket<BaseEventCorePresentableEvent>()
        presenter.presentables.addDelegate(bucket)
        
        /// Wake up the presenter
        presenter.viewController(didSend: .viewDidLoad)
        
        /// Set the expectations
        let expectation = self.expectation(description: "Expecting for books")
        
        firstly {
            after(seconds: 1.0)
        }.done { _ in
            
            /// Catch an elert event
            let alertEvent = bucket.events.compactMap(/BaseEventCorePresentableEvent.showAlert).last
            
            /// Assert that an alert has been shown
            XCTAssertNotNil(alertEvent)
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2)
    }
}
