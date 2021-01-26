//
//  QueryTablePresenterTests2.swift
//  HarryBookerTests
//
//  Created by Raymund Catahay on 2021-01-26.
//

import Foundation
import XCTest
import CasePaths
import OHHTTPStubs
import OHHTTPStubsSwift
import PromiseKit
@testable import HarryBooker

class QueryTablePresenterTests: XCTestCase {
    
    func testFirstOnLoadValue() {
        
        let stubs = QueryStubs()
        let query = "Harry"
        stubs.stubQuery(query: query, page: nil)
        
        let presenter = QueryTablePresenter(query: query)
        
        let bucket = PresentableBucket<QueryTablePresentableEvent>()
        presenter.presentables.addDelegate(bucket)
        
        /// Wake up the presenter
        presenter.viewController(didSend: .viewDidLoad)
        
        /// Set the expectations
        let expectation = self.expectation(description: "Expecting for books")
        
        firstly {
            after(seconds: 1.0)
        }.done { _ in
            guard let didLoadEvent = bucket.events.compactMap(/QueryTablePresentableEvent.didLoad).last else {
                expectation.fulfill()
                return
            }
            
            /// Assert thet we got 10 books on load
            assert(didLoadEvent.count == 2)
            
            let titles = didLoadEvent.map({ $0.title })
            let expectedTitles = [
                "BOOKTITLE1",
                "BOOKTITLE2"]
            
            /// Assert the expected book titles
            assert(titles.sorted() == expectedTitles.sorted())
            
            expectation.fulfill()
            stubs.reset()
        }
        
        waitForExpectations(timeout: 2)
    }
    
    func testFirstPullToRefreshLoadValue() {
        
        let stubs = QueryStubs()
        let query = "Harry"
        stubs.stubQuery(query: query, page: nil)
        stubs.stubQuery(query: query, page: "2")
        
        let presenter = QueryTablePresenter(query: query)
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
            
            /// Assert thet we got 10 books on load
            assert(didLoadEvent.count == 4)
            
            let titles = didLoadEvent.map({ $0.title })
            let expectedTitles = [
                "BOOKTITLE1",
                "BOOKTITLE2",
                "BOOKTITLE3",
                "BOOKTITLE4"]

            /// Assert the expected book titles
            assert(titles.sorted() == expectedTitles.sorted())
            
            expectation.fulfill()
            stubs.reset()
        }
        waitForExpectations(timeout: 5)
    }
}
