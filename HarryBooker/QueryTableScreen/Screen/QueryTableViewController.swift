//
//  QueryTableViewController.swift
//  QueryTableScreen
//
//  Created by Raymund Catahay on 2021-01-23.
//

import Foundation
import Eventful

public enum QueryTableEvent: Event { }

public class QueryTableViewController: BaseEventViewController<QueryTableEvent, QueryTableViewEvent, QueryTablePresenterEvent, QueryTablePresentableEvent> {
    
    let query: String
    
    public init(query: String) {
        self.query = query
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func preparePresenter() -> QueryTablePresenter {
        return QueryTablePresenter(query: query)
    }
    
    public override func prepareRootView() -> QueryTableView {
        return QueryTableView()
    }
}
