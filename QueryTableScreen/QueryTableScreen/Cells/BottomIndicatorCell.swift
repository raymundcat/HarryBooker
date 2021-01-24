//
//  BottomIndicatorCell.swift
//  QueryTableScreen
//
//  Created by Raymund Catahay on 2021-01-24.
//

import UIKit
import Design
import Anchorage

class BottomIndicatorCell: UITableViewCell {
    
    lazy var anchorView: UIView = {
        return UIView()
    }()
    
    lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.startAnimating()
        return indicator
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
        
        addSubview(anchorView)
        addSubview(loadingIndicator)
        
        anchorView.topAnchor == topAnchor + .extraLarge
        anchorView.bottomAnchor == bottomAnchor - .extraLarge
        anchorView.centerXAnchor == centerXAnchor
        
        loadingIndicator.centerAnchors == centerAnchors
    }
}
