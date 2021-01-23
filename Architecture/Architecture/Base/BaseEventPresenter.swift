//
//  BaseEventPresenter.swift
//  Architecture
//
//  Created by Raymund Catahay on 2021-01-23.
//

import Foundation
import Eventful
import MulticastDelegate

public enum BaseEventCorePresentableEvent: PresentableEvent {

    case shouldShowLoading(Bool)
    case showAlert(title: String?, message: String)
}

public protocol BaseEventCorePresentableEventListener: class {
    
    func presenter(didSend event: BaseEventCorePresentableEvent)
}

open class BaseEventPresenter<BaseEventViewEvent: ViewEvent, BaseEventPresenterEvent: PresenterEvent, BaseEventPresentableEvent: PresentableEvent>: EventPresenter<BaseEventViewEvent, BaseEventPresenterEvent, BaseEventPresentableEvent>, BaseEventViewControllerEventListener {
    
    //MARK: Events Sending
    
    public var corePresentableEventListeners = MulticastDelegate<BaseEventCorePresentableEventListener>()
    
    open func send(event: BaseEventCorePresentableEvent) {
        corePresentableEventListeners.invokeDelegates { (delegate) in
            delegate.presenter(didSend: event)
        }
    }
    
    //MARK: Events Catching
    
    override open func view(didSend event: ViewEvent) {
        if let viewEvent = event as? BaseEventViewEvent {
            self.view(didSend: viewEvent)
        }
    }

    // Generic Events Catching

    open override func view(didSend event: BaseEventViewEvent) { }
    
    open func viewController(didSend event: BaseEventViewControllerEvent) { }
}
