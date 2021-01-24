//
//  BookDetailCell.swift
//  QueryTableScreen
//
//  Created by Raymund Catahay on 2021-01-23.
//

import UIKit
import Anchorage
import SDWebImage

class BookDetailCell: UITableViewCell {
    
    private static let coverDimension: CGFloat = 60
    
    private lazy var coverView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Book"
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.text = "Book"
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private lazy var narratorLabel: UILabel = {
        let label = UILabel()
        label.text = "Book"
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        backgroundColor = .white
        
        addSubview(coverView)
        addSubview(titleLabel)
        addSubview(authorLabel)
        addSubview(narratorLabel)
        
        coverView.topAnchor == topAnchor + 12
        coverView.leadingAnchor == leadingAnchor + 12
        coverView.widthAnchor == Self.coverDimension
        coverView.heightAnchor == Self.coverDimension
        
        titleLabel.topAnchor == topAnchor + 12
        titleLabel.leadingAnchor == coverView.trailingAnchor + 12
        titleLabel.trailingAnchor == trailingAnchor - 12
        
        authorLabel.topAnchor == titleLabel.bottomAnchor + 12
        authorLabel.leadingAnchor == coverView.trailingAnchor + 12
        authorLabel.trailingAnchor == trailingAnchor - 12
        
        narratorLabel.topAnchor == authorLabel.bottomAnchor + 12
        narratorLabel.bottomAnchor == bottomAnchor - 12
        narratorLabel.leadingAnchor == coverView.trailingAnchor + 12
        narratorLabel.trailingAnchor == trailingAnchor - 12
    }
    
    func set(book: BookSummary) {
        titleLabel.text = book.title
        authorLabel.text = "By " + book.authors.map({ return $0.name }).joined(separator: ", ")
        narratorLabel.text = "with Narrator " + book.narrators.map({ return $0.name }).joined(separator: ", ")
        coverView.sd_setImage(with: URL(string: book.cover.url))
    }
}
