//
//  EventBucket.swift
//  HarryBookerTests
//
//  Created by Raymund Catahay on 2021-01-26.
//

import Foundation
import Eventful
@testable import HarryBooker

open class PresentableBucket<PresentableEventType: PresentableEvent>: PresentableEventListener {
    
    public var bucket = [PresentableEventType]()
    
    public func presenter(didSend event: PresentableEvent) {
        if let event = event as? PresentableEventType {
            bucket.append(event)
        }
    }
}
