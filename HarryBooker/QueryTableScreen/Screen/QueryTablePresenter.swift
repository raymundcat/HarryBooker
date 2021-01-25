//
//  QueryTablePresenter.swift
//  QueryTableScreen
//
//  Created by Raymund Catahay on 2021-01-23.
//

import Foundation
import Eventful
import Services

public enum QueryTablePresenterEvent: PresenterEvent { }

public enum QueryTablePresentableEvent: PresentableEvent {
    case didStart(query: String)
    case didLoad(books: [BookSummary])
}

public class QueryTablePresenter: BaseEventPresenter<QueryTableViewEvent, QueryTablePresenterEvent, QueryTablePresentableEvent> {
    
    private let query: String
    
    public init(query: String) {
        self.query = query
    }
    
    //MARK: Actions
    
    private var currentPage: String?
    
    private var books: [BookSummary] = []
    
    private var queryTask: URLSessionTask?
    private func fetchBooks() {
        guard queryTask == nil else { return }
        let endPoint = QueryEndPoint(
            path: .query(
                query: query,
                page: currentPage))
        send(event: .shouldShowLoading(true))
        queryTask = endPoint.request { (result: EndPointResult<BookQueryResult>) in
            switch result {
            case .success(let queryResult):
                self.updateBooks(queryResult: queryResult)
            case .failure:
                break
            }
            self.queryTask?.cancel()
            self.queryTask = nil
            self.send(event: .shouldShowLoading(false))
        }
    }
    
    private func updateBooks(queryResult: BookQueryResult) {
        self.currentPage = queryResult.nextPageToken
        self.filter(newBooks: queryResult.items) { (newBooks) in
            self.books.append(contentsOf: newBooks)
            self.send(event: .didLoad(books: self.books))
        }
    }
    
    private func filter(
        newBooks: [BookSummary],
        completion: @escaping ([BookSummary]) -> Void) {
        DispatchQueue.global().async {
            let filteredNewBooks = newBooks.filter({ !self.books.contains($0) })
            DispatchQueue.main.async {
                completion(filteredNewBooks)
            }
        }
    }
    
    //MARK: Events
    
    public override func viewController(didSend event: BaseEventViewControllerEvent) {
        switch event {
        case .viewDidLoad:
            /// Send an initial update
            send(event: .didStart(query: query))
            send(event: .didLoad(books: []))
            
            /// Start fetching the first set
            fetchBooks()
        default:
            break
        }
    }
    
    public override func view(didSend event: QueryTableViewEvent) {
        switch event {
        case .userDidPullUp:
            fetchBooks()
        }
    }
}
