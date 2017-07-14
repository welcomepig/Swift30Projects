//
//  FBGraphAPI+Search.swift
//  02 - FBSearch
//
//  Created by Tina Chang on 2017/7/12.
//  Copyright © 2017年 Tina Chang. All rights reserved.
//

import FacebookCore

#if !RX_NO_MODULE
import RxSwift
#endif

struct FBGraphSearchResponse: GraphResponseProtocol {
    var items: [FBGraphSearchItem] = []
    
    init(rawResponse: Any?) {
        if let json = rawResponse as? [String:Any],
            let items = json["data"] as? [[String:Any]] {
            self.items = items.map { item in
                FBUser(item)
            }
        }
    }
}

struct FBGraphSearchRequest: GraphRequestProtocol {
    typealias Response = FBGraphSearchResponse
    
    init(query: String, type: String) {
        self.query = query
        self.type = type
        self.graphPath = "/search"
        self.parameters = [ "fields": "id, name", "q": query, "type": type ]
    }
    
    let query: String
    let type: String
    let graphPath: String
    let parameters: [String : Any]?
    
    var accessToken = AccessToken.current
    var httpMethod: GraphRequestHTTPMethod = .GET
    var apiVersion: GraphAPIVersion = .defaultVersion
}

extension FBGraphAPI {    
    func search(_ query: String, type: String) -> Observable<[FBGraphSearchItem]> {
        return self.connection.rx.response(request: FBGraphSearchRequest(query: query, type: type))
            .map { res in
                res.items
        }
    }
}
