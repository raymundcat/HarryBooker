//
//  HeaderCell.swift
//  HarryBooker
//
//  Created by Raymund Catahay on 2021-01-25.
//

import UIKit
import Anchorage

class HeaderCell: UITableViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.font = .design(font: .header)
        label.textColor = .design(color: .text)
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
        backgroundColor = .design(color: .background)
        
        addSubview(titleLabel)
        titleLabel.topAnchor == topAnchor + .extraLarge
        titleLabel.bottomAnchor == bottomAnchor - .extraLarge
        titleLabel.centerXAnchor == centerXAnchor
    }
    
    func set(query: String) {
        titleLabel.text = "Query: \(query)"
    }
}
