//
//  QueryTablePresenter.swift
//  QueryTableScreen
//
//  Created by Raymund Catahay on 2021-01-23.
//

import Foundation
import Eventful
import Architecture
import Services
import API

public enum QueryTablePresenterEvent: PresenterEvent { }

public enum QueryTablePresentableEvent: PresentableEvent {
    case didLoad(books: [BookSummary])
}

public class QueryTablePresenter: BaseEventPresenter<QueryTableViewEvent, QueryTablePresenterEvent, QueryTablePresentableEvent> {
    
    //MARK: Actions
    
    private func fetchBooks() {
        let endPoint = QueryEndPoint(path: .query("harry"))
        endPoint.request { (result: EndPointResult<Query>) in
            switch result {
            case .success(let summary):
                self.send(event: .didLoad(books: summary.items))
            case .failure:
                break
            }
        }
    }
    
    //MARK: Events
    
    public override func viewController(didSend event: BaseEventViewControllerEvent) {
        switch event {
        case .viewDidLoad:
            self.fetchBooks()
        default:
            break
        }
    }
    
    public override func view(didSend event: QueryTableViewEvent) { }
}
