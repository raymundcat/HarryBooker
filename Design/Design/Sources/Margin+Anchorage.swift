//
//  Margin+Anchorage.swift
//  Design
//
//  Created by Raymund Catahay on 2021-01-24.
//

import UIKit
import Anchorage

@discardableResult public func + <T>(lhs: T, rhs: Margin) -> LayoutExpression<T, CGFloat> {
    return lhs + rhs.rawValue
}

@discardableResult public func - <T>(lhs: T, rhs: Margin) -> LayoutExpression<T, CGFloat> {
    return lhs - rhs.rawValue
}
