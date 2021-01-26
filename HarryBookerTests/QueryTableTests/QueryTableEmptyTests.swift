//
//  QueryTableEmptyTests.swift
//  HarryBookerTests
//
//  Created by Raymund Catahay on 2021-01-26.
//

import Foundation
import XCTest
import CasePaths
import PromiseKit
import OHHTTPStubs
import OHHTTPStubsSwift
@testable import HarryBooker

class QueryTableEmptyTests: StubbedTests {
    
    override class func setUp() {
        stub { (request) -> Bool in
            return request.url?.host == "api.storytel.net" &&
                request.url?.valueOf("query") == "Harry"
        } response: { (request) -> HTTPStubsResponse in
            guard let path = OHPathForFile("Query-Page-0-Empty.json", self) else {
                preconditionFailure("Could not find expected file in test bundle")
            }
            return HTTPStubsResponse(
                fileAtPath: path,
                statusCode: 200,
                headers: nil)
        }
        stub { (request) -> Bool in
            return request.url?.host == "api.storytel.net" &&
                request.url?.valueOf("query") == "Harry" &&
                request.url?.valueOf("page") == "2"
        } response: { (request) -> HTTPStubsResponse in
            guard let path = OHPathForFile("Query-Page-2-Empty.json", self) else {
                preconditionFailure("Could not find expected file in test bundle")
            }
            return HTTPStubsResponse(
                fileAtPath: path,
                statusCode: 200,
                headers: nil)
        }
    }
    
    func testFirstPullToRefreshLoadValue() {
        
        let presenter = QueryTablePresenter(query: "Harry")
        let bucket = PresentableBucket<QueryTablePresentableEvent>()
        presenter.presentables.addDelegate(bucket)
        
        /// Wake up the presenter
        presenter.viewController(didSend: .viewDidLoad)
        
        /// Set the expectations
        let expectation = self.expectation(description: "Expecting for books")
        
        firstly {
            after(seconds: 1.0)
        }.then { _ in
            return Guarantee<()> { resolver in
                presenter.view(didSend: .userDidPullUp)
                resolver(())
            }
        }.then {
            after(seconds: 1.0)
        }.done { _ in
            guard let didLoadEvent = bucket.events.compactMap(/QueryTablePresentableEvent.didLoad).last else {
                expectation.fulfill()
                return
            }
            
            /// Assert thet we got no books on load
            assert(didLoadEvent.count == 0)
            
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3)
    }
}



