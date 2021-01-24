//
//  QueryService.swift
//  API
//
//  Created by Raymund Catahay on 2021-01-23.
//

import Foundation
import Services

public enum QueryPath: Path {
    case query(query: String, page: String?)
}

public class QueryEndPoint: EndPoint<QueryPath> {
    
    public override var url: URL? {
        var url = URL(string: "https://api.storytel.net")
        switch path {
        case .query:
            url?.appendPathComponent("search")
        }
        return url
    }
    
    public override var urlParameter: URLParameter? {
        switch path {
        case .query(let query, let page):
            var queryDict = [String : String]()
            queryDict["query"] = query
            if let page = page {
                queryDict["page"] = page
            }
            return .dictionary(parameters: queryDict)
        }
    }
}
