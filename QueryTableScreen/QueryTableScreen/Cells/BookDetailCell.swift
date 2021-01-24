//
//  BookDetailCell.swift
//  QueryTableScreen
//
//  Created by Raymund Catahay on 2021-01-23.
//

import UIKit
import Design
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
        label.font = .title
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.text = "Book"
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .darkGray
        label.font = .description
        return label
    }()
    
    private lazy var narratorLabel: UILabel = {
        let label = UILabel()
        label.text = "Book"
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .darkGray
        label.font = .description
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
        selectionStyle = .none
        backgroundColor = .white
        
        addSubview(coverView)
        addSubview(titleLabel)
        addSubview(authorLabel)
        addSubview(narratorLabel)
        
        coverView.topAnchor == topAnchor + .regular
        coverView.leadingAnchor == leadingAnchor + .large
        coverView.widthAnchor == Self.coverDimension
        coverView.heightAnchor == Self.coverDimension
        
        titleLabel.topAnchor == topAnchor + .regular
        titleLabel.leadingAnchor == coverView.trailingAnchor + .large
        titleLabel.trailingAnchor == trailingAnchor - .large
        
        authorLabel.topAnchor == titleLabel.bottomAnchor + .regular
        authorLabel.leadingAnchor == coverView.trailingAnchor + .large
        authorLabel.trailingAnchor == trailingAnchor - .large
        
        narratorLabel.topAnchor == authorLabel.bottomAnchor
        narratorLabel.bottomAnchor == bottomAnchor - .regular
        narratorLabel.leadingAnchor == coverView.trailingAnchor + .large
        narratorLabel.trailingAnchor == trailingAnchor - .large
    }
    
    func set(book: BookSummary) {
        titleLabel.text = book.title
        authorLabel.text = "By " + book.authors.map({ return $0.name }).joined(separator: ", ")
        narratorLabel.text = "with Narrator " + book.narrators.map({ return $0.name }).joined(separator: ", ")
        coverView.sd_setImage(with: URL(string: book.cover.url))
    }
}
