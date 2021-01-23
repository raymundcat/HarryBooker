//
//  QueryTableView.swift
//  QueryTableScreen
//
//  Created by Raymund Catahay on 2021-01-23.
//

import UIKit
import Eventful
import Architecture
import Anchorage

public enum QueryTableViewEvent: ViewEvent { }

public  class QueryTableView: BaseEventRootView<QueryTableViewEvent, QueryTablePresentableEvent> {
    
    //MARK: Subviews
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    public override func setup() {
        /// Self setup
        backgroundColor = .white
        
        /// Children
        addSubview(tableView)
        tableView.topAnchor == safeAreaLayoutGuide.topAnchor
        tableView.bottomAnchor == safeAreaLayoutGuide.bottomAnchor
        tableView.leadingAnchor == leadingAnchor
        tableView.trailingAnchor == trailingAnchor
    }
    
    public override func presenter(didSend event: QueryTablePresentableEvent) {
        
    }
}
