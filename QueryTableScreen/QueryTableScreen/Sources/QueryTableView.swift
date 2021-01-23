//
//  QueryTableView.swift
//  QueryTableScreen
//
//  Created by Raymund Catahay on 2021-01-23.
//

import UIKit
import Eventful
import Architecture

public enum QueryTableViewEvent: ViewEvent { }

public  class QueryTableView: BaseEventRootView<QueryTableViewEvent, QueryTablePresentableEvent> {
    
    public override func setup() {
        
    }
    
    public override func presenter(didSend event: QueryTablePresentableEvent) {
        
    }
}
