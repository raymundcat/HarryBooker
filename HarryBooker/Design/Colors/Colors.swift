//
//  Colors.swift
//  HarryBooker
//
//  Created by Raymund Catahay on 2021-01-25.
//

import UIKit

public extension UIColor {
    
    enum DesignColor {
        case background
        case text
        case subText
    }
    
    class func design(color: DesignColor) -> UIColor {
        let designColor: UIColor?
        switch color {
        case .background:
            designColor = UIColor(named: "Background")
        case .text:
            designColor = UIColor(named: "Text")
        case .subText:
            designColor = UIColor(named: "SubText")
        }
        return designColor ?? .black
    }
}
