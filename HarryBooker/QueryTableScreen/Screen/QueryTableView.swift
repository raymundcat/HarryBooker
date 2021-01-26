//
//  QueryTableView.swift
//  QueryTableScreen
//
//  Created by Raymund Catahay on 2021-01-23.
//

import UIKit
import Eventful
import Anchorage

enum QueryTableSection: CaseIterable {
    case header
    case books
}

enum QueryTableRow: Hashable {
    case headerCell
    case book(BookSummary)
}

typealias DataSource = UITableViewDiffableDataSource<QueryTableSection, QueryTableRow>

typealias Snapshot = NSDiffableDataSourceSnapshot<QueryTableSection, QueryTableRow>

public enum QueryTableViewEvent: ViewEvent {
    case userDidPullUp
}

public  class QueryTableView: BaseEventRootView<QueryTableViewEvent, QueryTablePresentableEvent> {
    
    private var query: String?
    
    //MARK: Subviews
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .design(color: .background)
        return tableView
    }()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        return indicator
    }()
    
    private lazy var dataSource: DataSource = {
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
    }()
    
    //MARK: LifeCycle
    
    public override func setup() {
        /// Self setup
        backgroundColor = .design(color: .background)
        
        /// Children
        addSubview(tableView)
        addSubview(loadingIndicator)
        
        tableView.topAnchor == safeAreaLayoutGuide.topAnchor
        tableView.bottomAnchor == safeAreaLayoutGuide.bottomAnchor
        tableView.leadingAnchor == leadingAnchor
        tableView.trailingAnchor == trailingAnchor
        
        loadingIndicator.centerAnchors == centerAnchors
    }
    
    //MARK: Actions
    
    private func updateItems(books: [BookSummary], animated: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections(QueryTableSection.allCases)
        for section in snapshot.sectionIdentifiers {
            switch section {
            case .header:
                snapshot.appendItems([.headerCell], toSection: .header)
            case .books:
                let bookRows = books.map({ QueryTableRow.book($0) })
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
    
    private func updateLoadingIndicator(isShown: Bool) {
        
        /// Show or hide activity indicators
        if isShown {
            loadingIndicator.startAnimating()
        } else {
            loadingIndicator.stopAnimating()
        }
        
        /// Let's hold off further user interactions
        /// while the presenter is busy
        isUserInteractionEnabled = !isShown
    }
    
    //MARK: Events
    
    public override func presenter(didSend event: QueryTablePresentableEvent) {
        switch event {
        case .didStart(let query):
            self.query = query
        case .didLoad(let books):
            updateItems(books: books)
        }
    }
    
    public override func presenter(didSend event: BaseEventCorePresentableEvent) {
        switch event {
        case .shouldShowLoading(let shoudShow):
            updateLoadingIndicator(isShown: shoudShow)
        default:
            break
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
