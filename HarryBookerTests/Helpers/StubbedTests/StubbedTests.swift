//
//  StubbedTests.swift
//  HarryBookerTests
//
//  Created by Raymund Catahay on 2021-01-26.
//

import XCTest

open class StubbedTests: XCTestCase {
    
    public var stubs = QueryStubs()
    
    open override func tearDown() {
        stubs.reset()
    }
}
