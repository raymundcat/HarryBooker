//
//  QueryTableView.swift
//  QueryTableScreen
//
//  Created by Raymund Catahay on 2021-01-23.
//

import UIKit
import Eventful
import Architecture
import Design
import Anchorage

enum QueryTableSection: CaseIterable {
    case books
    case bottomIndicator
}

enum QueryTableRow: Hashable {
    case book(BookSummary)
    case loadingIndicator
}

typealias DataSource = UITableViewDiffableDataSource<QueryTableSection, QueryTableRow>

typealias Snapshot = NSDiffableDataSourceSnapshot<QueryTableSection, QueryTableRow>

public enum QueryTableViewEvent: ViewEvent {
    case userDidPullUp
}

public  class QueryTableView: BaseEventRootView<QueryTableViewEvent, QueryTablePresentableEvent> {
    
    //MARK: Subviews
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    lazy var dataSource: DataSource = {
        let dataSource = DataSource(tableView: tableView) { (tableView, indexPath, row) -> UITableViewCell? in
            switch row {
            case .book(let book):
                let cell: BookDetailCell = tableView.dequeueReusableCell(for: indexPath)
                cell.set(book: book)
                return cell
            case .loadingIndicator:
                let cell: BottomIndicatorCell = tableView.dequeueReusableCell(for: indexPath)
                cell.loadingIndicator.startAnimating()
                return cell
            }
        }
        return dataSource
    }()
    
    //MARK: States
    
    private var books: [BookSummary] = [] {
        didSet {
            updateItems()
        }
    }
    
    private var isIndicatorShown: Bool = false {
        didSet {
            updateItems()
        }
    }
    
    //MARK: LifeCycle
    
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
    
    //MARK: Actions
    
    func updateItems(animated: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections(QueryTableSection.allCases)
        for section in snapshot.sectionIdentifiers {
            switch section {
            case .books:
                let bookRows = books.map({ QueryTableRow.book($0) })
                snapshot.appendItems(
                    bookRows,
                    toSection: section)
            case .bottomIndicator:
                if isIndicatorShown {
                    snapshot.appendItems(
                        [.loadingIndicator],
                        toSection: .bottomIndicator)
                } else {
                    snapshot.deleteItems([.loadingIndicator])
                }
            }
        }
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: animated)
        }
    }
    
    var pullUpDelayTimer: Timer?
    func requestPullUp() {
        pullUpDelayTimer?.invalidate()
        pullUpDelayTimer = Timer(
            timeInterval: 1,
            repeats: false,
            block: { (timer) in
            self.send(event: .userDidPullUp)
        })
        pullUpDelayTimer?.fire()
    }
    
    //MARK: Events
    
    public override func viewController(didSend event: BaseEventViewControllerEvent) {
        switch event {
        case .viewDidLoad:
            updateItems(animated: false)
        default:
            break
        }
    }
    
    public override func presenter(didSend event: QueryTablePresentableEvent) {
        switch event {
        case .didLoad(let books):
            self.books.append(contentsOf: books)
        }
    }
    
    public override func presenter(didSend event: BaseEventCorePresentableEvent) {
        switch event {
        case .shouldShowLoading(let shoudShow):
            isIndicatorShown = shoudShow
        default:
            break
        }
    }
}

extension QueryTableView: UITableViewDelegate, UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y + scrollView.bounds.height
        let contentHeight = scrollView.contentSize.height
        if offset > contentHeight + 100 {
            requestPullUp()
        }
    }
}
