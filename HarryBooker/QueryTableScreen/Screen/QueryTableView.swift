//
//  QueryTableView.swift
//  QueryTableScreen
//
//  Created by Raymund Catahay on 2021-01-23.
//

import UIKit
import Eventful
import Anchorage

public enum QueryTableViewEvent: ViewEvent {
    case userDidPullUp
}

public class QueryTableView: BaseEventRootView<QueryTableViewEvent, QueryTablePresentableEvent> {
    
    //MARK: Properties
    
    private var query: String?
    
    //MARK: Subviews
    
    private lazy var dataSource: DataSource = prepareDataSource()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .design(color: .background)
        return tableView
    }()
    
    //MARK: LifeCycle
    
    public override func setup() {
        /// Self setup
        backgroundColor = .design(color: .background)
        
        /// Children
        addSubview(tableView)
        
        tableView.topAnchor == safeAreaLayoutGuide.topAnchor
        tableView.bottomAnchor == safeAreaLayoutGuide.bottomAnchor
        tableView.leadingAnchor == leadingAnchor
        tableView.trailingAnchor == trailingAnchor
    }
    
    public override func setupLoadingIndicator() {
        addSubview(loadingIndicator)
        loadingIndicator.centerXAnchor == centerXAnchor
        loadingIndicator.bottomAnchor == safeAreaLayoutGuide.bottomAnchor - .regular
    }
    
    //MARK: Events
    
    public override func presenter(didSend event: QueryTablePresentableEvent) {
        switch event {
        case .didStartQuery(let query):
            self.query = query
        case .didLoadBooks(let books):
            updateItems(books: books)
        }
    }
}

// MARK: UITableView DataSource

extension QueryTableView {
    
    enum TableSection: CaseIterable {
        case header
        case books
    }

    enum TableRow: Hashable {
        case headerCell
        case book(BookSummary)
    }
    
    typealias DataSource = UITableViewDiffableDataSource<TableSection, TableRow>
    
    private func prepareDataSource() -> DataSource {
        let dataSource = DataSource(tableView: tableView) { (tableView, indexPath, row) -> UITableViewCell? in
            switch row {
            case .book(let book):
                let cell: BookDetailCell = tableView.dequeueReusableCell(for: indexPath)
                cell.set(book: book)
                return cell
            case .headerCell:
                let cell: HeaderCell = tableView.dequeueReusableCell(for: indexPath)
                if let query = self.query {
                    cell.set(query: query)
                }
                return cell
            }
        }
        return dataSource
    }
    
    typealias Snapshot = NSDiffableDataSourceSnapshot<TableSection, TableRow>
    
    private func updateItems(books: [BookSummary], animated: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections(TableSection.allCases)
        for section in snapshot.sectionIdentifiers {
            switch section {
            case .header:
                snapshot.appendItems([.headerCell], toSection: .header)
            case .books:
                let bookRows = books.map({ TableRow.book($0) })
                snapshot.appendItems(
                    bookRows.filter({ !snapshot.itemIdentifiers.contains($0) }),
                    toSection: section)
            }
        }
        tableView.showsVerticalScrollIndicator = false
        dataSource.apply(
            snapshot,
            animatingDifferences: animated) {
            self.tableView.showsVerticalScrollIndicator = true
        }
    }
}

extension QueryTableView: UITableViewDelegate, UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y + scrollView.bounds.height
        let contentHeight = scrollView.contentSize.height
        
        /// The trigger for a  reload
        if offset > contentHeight + 120 {
            send(event: .userDidPullUp)
        }
    }
}
