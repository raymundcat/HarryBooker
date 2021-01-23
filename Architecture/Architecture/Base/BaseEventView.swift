//
//  BaseEventView.swift
//  Architecture
//
//  Created by Raymund Catahay on 2021-01-23.
//

import UIKit
import Eventful
import Anchorage

open class BaseEventRootView<BaseEventViewEvent: ViewEvent, BaseEventPresentableEvent: PresentableEvent>: EventRootView<BaseEventViewEvent, BaseEventPresentableEvent>, BaseEventViewControllerEventListener, BaseEventCorePresentableEventListener {
    
    //MARK: Life Cycle
    
    public override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setup() { }
    
    //MARK: Events Catching
    
    open override func presenter(didSend event: PresentableEvent) {
        if let presenterEvent = event as? BaseEventPresentableEvent {
            self.presenter(didSend: presenterEvent)
        }
    }

    // MARK: Generic Event Catching

    open override func presenter(didSend event: BaseEventPresentableEvent) { }
    
    open func viewController(didSend event: BaseEventViewControllerEvent) { }
    
    open func presenter(didSend event: BaseEventCorePresentableEvent) { }
}
