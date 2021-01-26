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
@testable import HarryBooker

class QueryTablePresenterTests: XCTestCase {

    let stubs = QueryStubs()
    
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            guard let didLoadEvent = bucket.events.compactMap(/QueryTablePresentableEvent.didLoad).last else {
                expectation.fulfill()
                return
            }
            
            /// Assert thet we got 10 books on load
            assert(didLoadEvent.count == 10)
            
            let titles = didLoadEvent.map({ $0.title })
            let expectedTitles = [
                "Scary Harry: Fledermaus frei Haus",
                "Harry Potter e a Pedra Filosofal",
                "Harry Potter e a Câmara Secreta",
                "Harry Potter and the Chamber of Secrets",
                "Harry Potter and the Deathly Hallows",
                "Harry Potter and the Goblet of Fire",
                "Harry Potter and the Order of the Phoenix",
                "Harry Potter and the Philosopher\'s Stone",
                "Harry Potter and the Prisoner of Azkaban",
                "Harry Potter and the Half-Blood Prince"]
            
            /// Assert the expected book titles
            assert(titles.sorted() == expectedTitles.sorted())
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
    }
}
