//
//  BookDetail.swift
//  QueryTableScreen
//
//  Created by Raymund Catahay on 2021-01-23.
//

import Foundation

struct BookSummary: Codable, Identifiable {
    let id: String
    let title: String
    let authors: [Person]
    let narrators: [Person]
}

struct Person: Codable, Identifiable {
    let id: String
    let name: String
}

struct Query: Codable {
    let nextPageToken: String
    let items: [BookSummary]
}
