//
//  Fonts.swift
//  Design
//
//  Created by Raymund Catahay on 2021-01-24.
//

import UIKit

public extension UIFont {
    
    enum DesignFont {
        case header
        case title
        case description
    }
    
    class func design(font: DesignFont) -> UIFont {
        switch font {
        case .header:
            return .systemFont(ofSize: 32, weight: .bold)
        case .title:
            return .systemFont(ofSize: 24, weight: .semibold)
        case .description:
            return .systemFont(ofSize: 16, weight: .light)
        }
    }
}
