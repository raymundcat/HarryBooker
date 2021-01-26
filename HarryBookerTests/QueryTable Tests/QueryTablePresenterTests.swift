//
//  QueryTablePresenterTests.swift
//  HarryBookerTests
//
//  Created by Raymund Catahay on 2021-01-26.
//

import Foundation
import XCTest
import OHHTTPStubsSwift
@testable import HarryBooker

class QueryTablePresenterTests: XCTestCase {

    let stubs = QueryStubs()
    
    func testOnLoadValues() {
        stubs.stubQuery(page: nil)
        
        let presenter = QueryTablePresenter(query: "Harry")
        let bucket = PresentableBucket<QueryTablePresentableEvent>()
        presenter.presentables.addDelegate(bucket)
        
        /// Wake up the presenter
        presenter.viewController(didSend: .viewDidLoad)
        
        assert(bucket.bucket.count == 10)
    }
}
