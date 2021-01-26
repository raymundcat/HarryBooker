//
//  BaseEventViewController.swift
//  Architecture
//
//  Created by Raymund Catahay on 2021-01-23.
//

import UIKit
import Eventful
import MulticastDelegate

public enum BaseEventViewControllerEvent: Event {

    // Life Cycle Events
    case viewDidLoad
    case viewWillAppear(animate: Bool)
    case viewDidAppear(animated: Bool)
    case viewWillDisappear(animated: Bool)
    case viewDidDisappear(animated: Bool)
}

public protocol BaseEventViewControllerEventListener: class {
    
    func viewController(didSend event: BaseEventViewControllerEvent)
}

open class BaseEventViewController<BaseEventEvent: Event, BaseEventViewEvent: ViewEvent, BaseEventPresenterEvent: PresenterEvent, BaseEventPresentableEvent: PresentableEvent>: EventViewController<BaseEventEvent, BaseEventViewEvent, BaseEventPresenterEvent, BaseEventPresentableEvent> {
    
    //MARK: Life Cycle
    
    public override func setupBindings() {
        super.setupBindings()
        
        // ViewController Events
        if let rootView = rootView as? BaseEventRootView,
           let rootPresenter = rootPresenter as? BaseEventPresenter {
            
            // Attach View Controller Events
            viewControllerEventListeners.addDelegate(rootView)
            viewControllerEventListeners.addDelegate(rootPresenter)
        }
    }
    
    //MARK: Events Sending
    
    public var viewControllerEventListeners = MulticastDelegate<BaseEventViewControllerEventListener>()
    
    open func send(event: BaseEventViewControllerEvent) {
        viewControllerEventListeners.invokeDelegates { (delegate) in
            delegate.viewController(didSend: event)
        }
    }
    
    //MARK: Events Listening

    open override func presenter(didSend event: PresenterEvent) {
        if let presenterEvent = event as? BaseEventPresenterEvent {
            self.presenter(didSend: presenterEvent)
        }
    }

    open override func presenter(didSend event: BaseEventPresenterEvent) { }
    
    // MARK: Overriding functions

    public override func viewDidLoad() {
        super.viewDidLoad()
        send(event: .viewDidLoad)
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        send(event: .viewWillAppear(animate: animated))
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        send(event: .viewDidAppear(animated: animated))
    }

    public override func viewWillDisappear(_ animated: Bool) {
        send(event: .viewWillDisappear(animated: animated))
        super.viewWillDisappear(animated)
    }

    public override func viewDidDisappear(_ animated: Bool) {
        send(event: .viewDidDisappear(animated: animated))
        super.viewDidDisappear(animated)
    }
}
