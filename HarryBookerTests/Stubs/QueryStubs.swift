//
//  QueryStubs.swift
//  HarryBookerTests
//
//  Created by Raymund Catahay on 2021-01-26.
//

import Foundation
import OHHTTPStubs
import OHHTTPStubsSwift

public class QueryStubs {
    
    public func stubQuery(page: String?) {
        stub { (request) -> Bool in
            return true
        } response: { (request) -> HTTPStubsResponse in
            return HTTPStubsResponse(
                fileAtPath: "",
                statusCode: 200,
                headers: [ "Content-Type": "application/json" ])
        }
    }
}
