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
    
    public func stubQuery(query: String, page: String?) {
        stub { (request) -> Bool in
            if let page = page {
                return request.url?.absoluteString == "https://api.storytel.net/search?query=\(query)&page=\(page)"
            } else {
                return request.url?.absoluteString == "https://api.storytel.net/search?query=\(query)"
            }
        } response: { (request) -> HTTPStubsResponse in
            var pathString: String
            if let page = page {
                pathString = "Query-Page-\(page).json"
            } else {
                pathString = "Query-Page-0.json"
            }
            guard let path = OHPathForFile(pathString, type(of: self)) else {
                preconditionFailure("Could not find expected file in test bundle")
            }
            return HTTPStubsResponse(
                fileAtPath: path,
                statusCode: 200,
                headers: ["Content-Type": "application/json"])
        }
    }
}
