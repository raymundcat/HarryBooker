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
    
    public override func preparePresenter() -> QueryTablePresenter {
        return QueryTablePresenter()
    }
    
    public override func prepareRootView() -> QueryTableView {
        return QueryTableView()
    }
}
