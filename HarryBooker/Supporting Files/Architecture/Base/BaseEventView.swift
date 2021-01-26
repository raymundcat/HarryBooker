//
//  BaseEventView.swift
//  Architecture
//
//  Created by Raymund Catahay on 2021-01-23.
//

import UIKit
import Anchorage
import Eventful

open class BaseEventRootView<BaseEventViewEvent: ViewEvent, BaseEventPresentableEvent: PresentableEvent>: EventRootView<BaseEventViewEvent, BaseEventPresentableEvent>, BaseEventViewControllerEventListener, BaseEventCorePresentableEventListener {
    
    //MARK: Subviews
    
    public lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        return indicator
    }()
    
    //MARK: Life Cycle
    
    public override init(frame: CGRect) {
        super.init(frame: .zero)
        setupLoadingIndicator()
        setup()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setup() { }
    
    open func setupLoadingIndicator() {
        addSubview(loadingIndicator)
        loadingIndicator.centerAnchors == centerAnchors
    }
    
    //MARK: Baked in Actions
    
    open func showIndicator(shouldShow: Bool) {
        /// Temporarily halt user interactions
        isUserInteractionEnabled = !shouldShow
        
        /// Start or stop indicators
        if shouldShow {
            bringSubviewToFront(loadingIndicator)
            loadingIndicator.startAnimating()
        } else {
            loadingIndicator.stopAnimating()
        }
    }
    
    open func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        
        /// Quickly attempt to acces our parent viewcontroller
        if let parent = next as? UIViewController {
            parent.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK: Events Catching
    
    open override func presenter(didSend event: PresentableEvent) {
        if let presenterEvent = event as? BaseEventPresentableEvent {
            self.presenter(didSend: presenterEvent)
        }
    }

    // MARK: Generic Event Catching

    open override func presenter(didSend event: BaseEventPresentableEvent) { }
    
    open func viewController(didSend event: BaseEventViewControllerEvent) { }
    
    open func presenter(didSend event: BaseEventCorePresentableEvent) {
        switch event {
        case .shouldShowLoading(let shouldShow):
            showIndicator(shouldShow: shouldShow)
        case .showAlert(let title, let message):
            showAlert(title: title, message: message)
        }
    }
}
