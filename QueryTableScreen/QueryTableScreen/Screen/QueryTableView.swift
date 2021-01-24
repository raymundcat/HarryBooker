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

enum QueryTableSection: CaseIterable {
    case query
    case books
}

typealias DataSource = UITableViewDiffableDataSource<QueryTableSection, BookSummary>

typealias Snapshot = NSDiffableDataSourceSnapshot<QueryTableSection, BookSummary>

public enum QueryTableViewEvent: ViewEvent {
    case userDidReachBottom
}

public  class QueryTableView: BaseEventRootView<QueryTableViewEvent, QueryTablePresentableEvent> {
    
    //MARK: Subviews
    
    lazy var tableView: UITableView = {
        return UITableView()
    }()
    
    lazy var dataSource: DataSource = {
        return DataSource(tableView: tableView) { (tableView, indexPath, book) -> UITableViewCell? in
            let cell: BookDetailCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }()
    
    //MARK: LifeCycle
    
    func updateItems(books: [BookSummary], animated: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections(QueryTableSection.allCases)
        for section in snapshot.sectionIdentifiers {
            switch section {
            case .query:
                break
            case .books:
                snapshot.appendItems(books, toSection: section)
            }
        }
        dataSource.apply(snapshot, animatingDifferences: animated)
    }
    
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
    
    public override func viewController(didSend event: BaseEventViewControllerEvent) {
        switch event {
        case .viewDidLoad:
            updateItems(books: [], animated: false)
        default:
            break
        }
    }
    
    public override func presenter(didSend event: QueryTablePresentableEvent) {
        switch event {
        case .didLoad(let books):
            updateItems(books: books)
        }
    }
}
