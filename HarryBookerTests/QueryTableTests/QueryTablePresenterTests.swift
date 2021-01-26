//
//  QueryTablePresenterTests2.swift
//  HarryBookerTests
//
//  Created by Raymund Catahay on 2021-01-26.
//

import Foundation
import XCTest
import CasePaths
import PromiseKit
@testable import HarryBooker

class QueryTablePresenterTests: StubbedTests {
    
    func testFirstOnLoadValue() {
        
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
        }
        
        waitForExpectations(timeout: 2)
    }
}
