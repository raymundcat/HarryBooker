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
    
    private var books: [BookSummary] = []
    
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

extension QueryTableView: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: BookDetailCell = tableView.dequeueReusableCell(for: indexPath)
        return cell
    }
}
