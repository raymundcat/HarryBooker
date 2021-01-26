//
//  QueryTablePresenter.swift
//  QueryTableScreen
//
//  Created by Raymund Catahay on 2021-01-23.
//

import Foundation
import Eventful
import Services
import PromiseKit

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
    
    //MARK: Stored Properties
    
    private var currentPage: String?
    
    private var books: [BookSummary] = []
    
    //MARK: Actions
    
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
                let title = "Sorry"
                let message = "There seems to be a problem loading your books. Please try again."
                self.send(event: .showAlert(title: title, message: message))
            }
            self.queryTask?.cancel()
            self.queryTask = nil
            self.send(event: .shouldShowLoading(false))
        }
    }
    
    private func updateBooks(queryResult: BookQueryResult) {
        
        /// Since our tableView has a very sensitive diffing
        /// We need to double check that the books received
        /// is not a duplicate of already shown
        func filter(
            newBooks: [BookSummary],
            completion: @escaping ([BookSummary]) -> Void) {
            firstly {
                Guarantee<[BookSummary]> { guarantee in
                    DispatchQueue.global().async {
                        let filteredNewBooks = newBooks.filter({ !self.books.contains($0) })
                        guarantee(filteredNewBooks)
                    }
                }
            }.done { (newBooks) in
                DispatchQueue.main.async {
                    completion(newBooks)
                }
            }
        }
        
        currentPage = queryResult.nextPageToken
        filter(newBooks: queryResult.items) { (newBooks) in
            self.books.append(contentsOf: newBooks)
            self.send(event: .didLoad(books: self.books))
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
