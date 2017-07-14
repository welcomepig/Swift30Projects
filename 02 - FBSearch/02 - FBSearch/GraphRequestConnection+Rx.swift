//
//  RxFBGraphRequest.swift
//  02 - FBSearch
//
//  Created by Tina Chang on 2017/7/10.
//  Copyright © 2017年 Tina Chang. All rights reserved.
//

import Foundation
import FacebookCore
#if !RX_NO_MODULE
import RxSwift
#endif

extension GraphRequestConnection: ReactiveCompatible {}
extension Reactive where Base: GraphRequestConnection {
    
    public func response<T: GraphRequestProtocol>(request: T) -> Observable<T.Response> {
        return Observable.create { observer in
            let connection = GraphRequestConnection()
        
            connection.add(request) { response, result in
                switch result {
                case .success(let response):
                    observer.on(.next(response))
                    observer.on(.completed)
                case .failed(let error):
                    observer.on(.error(error))
                }
            }
            connection.start()
            return Disposables.create()
        }
    }
    
}
