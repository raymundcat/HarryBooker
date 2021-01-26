//
//  StubbedTests.swift
//  HarryBookerTests
//
//  Created by Raymund Catahay on 2021-01-26.
//

import XCTest
import OHHTTPStubs
import OHHTTPStubsSwift

open class StubbedTests: XCTestCase {
    
    open override func tearDown() {
        HTTPStubs.removeAllStubs()
    }
}
