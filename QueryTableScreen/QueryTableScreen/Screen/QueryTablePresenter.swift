//
//  QueryTablePresenter.swift
//  QueryTableScreen
//
//  Created by Raymund Catahay on 2021-01-23.
//

import Foundation
import Eventful
import Architecture
import Services
import API

public enum QueryTablePresenterEvent: PresenterEvent { }

public enum QueryTablePresentableEvent: PresentableEvent { }

public class QueryTablePresenter: BaseEventPresenter<QueryTableViewEvent, QueryTablePresenterEvent, QueryTablePresentableEvent> {
    
    public override func viewController(didSend event: BaseEventViewControllerEvent) {
        switch event {
        case .viewDidLoad:
            let endPoint = QueryEndPoint(path: .query("harry"))
            endPoint.request { (result: EndPointResult<Query>) in
                switch result {
                case .success(let summary):
                    print(summary)
                case .failure:
                    break
                }
            }
        default:
            break
        }
    }
    
    public override func view(didSend event: QueryTableViewEvent) { }
}
