//
//  Fonts.swift
//  Design
//
//  Created by Raymund Catahay on 2021-01-24.
//

import UIKit

public extension UIFont {
    
    class var header: UIFont {
        return .systemFont(ofSize: 32, weight: .bold)
    }
    
    class var title: UIFont {
        return .systemFont(ofSize: 24, weight: .semibold)
    }
    
    class var description: UIFont {
        return .systemFont(ofSize: 16, weight: .light)
    }
}
