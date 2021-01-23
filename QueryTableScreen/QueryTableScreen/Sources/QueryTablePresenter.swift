//
//  QueryTablePresenter.swift
//  QueryTableScreen
//
//  Created by Raymund Catahay on 2021-01-23.
//

import Foundation
import Eventful
import Architecture
import API

public enum QueryTablePresenterEvent: PresenterEvent { }

public enum QueryTablePresentableEvent: PresentableEvent { }

public class QueryTablePresenter: BaseEventPresenter<QueryTableViewEvent, QueryTablePresenterEvent, QueryTablePresentableEvent> {
    
    public override func viewController(didSend event: BaseEventViewControllerEvent) { }
    
    public override func view(didSend event: QueryTableViewEvent) { }
}
