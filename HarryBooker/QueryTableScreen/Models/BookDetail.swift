//
//  BookDetail.swift
//  QueryTableScreen
//
//  Created by Raymund Catahay on 2021-01-23.
//

import Foundation

public struct BookSummary: Codable, Identifiable {
    
    public let id: String
    public let title: String
    public let cover: BookCover
    public let authors: [Person]
    public let narrators: [Person]
}

extension BookSummary: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: BookSummary, rhs: BookSummary) -> Bool {
        lhs.id == rhs.id
    }
}

public struct BookCover: Codable {
    public let url: String
}

public struct Person: Codable, Identifiable {
    public let id: String
    public let name: String
}

public struct Query: Codable {
    public let nextPageToken: String
    public let items: [BookSummary]
}
