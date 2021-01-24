//
//  BookDetailCell.swift
//  QueryTableScreen
//
//  Created by Raymund Catahay on 2021-01-23.
//

import UIKit
import Anchorage

class BookDetailCell: UITableViewCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Book"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        backgroundColor = .white
        
        addSubview(titleLabel)
        
        titleLabel.topAnchor == contentView.topAnchor
        titleLabel.bottomAnchor == contentView.bottomAnchor
        titleLabel.leadingAnchor == titleLabel.leadingAnchor
        titleLabel.trailingAnchor == titleLabel.trailingAnchor
    }
}
