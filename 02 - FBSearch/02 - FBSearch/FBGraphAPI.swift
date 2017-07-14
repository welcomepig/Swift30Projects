//
//  FFBGraphAPIProtocol.swift
//  02 - FBSearch
//
//  Created by Tina Chang on 2017/7/9.
//  Copyright © 2017年 Tina Chang. All rights reserved.
//

import FacebookCore

#if !RX_NO_MODULE
import RxSwift
#endif

protocol FBGraphAPIProtocol {
    func search(_ query: String, type: String) -> Observable<[FBGraphSearchItem]>
}

class MockFBGraphAPI : FBGraphAPIProtocol {
    static let sharedAPI = MockFBGraphAPI()
    
    func search(_ query: String, type: String) -> Observable<[FBGraphSearchItem]> {
        let response = "{\"data\":[{\"name\":\"Dawn Chang\",\"id\":\"331363993915201\"},{\"name\":\"Kinembe Changu Kuma Yangu\",\"id\":\"162999380876721\"},{\"name\":\"Ji Chang Wook\",\"id\":\"271942953284304\"},{\"name\":\"Ji Chang Wook\",\"id\":\"150698662155804\"},{\"name\":\"Dawn Chang\",\"id\":\"133744750548681\"},{\"name\":\"Rihana Chang\",\"id\":\"290139654783153\"},{\"name\":\"Dawn Chang\",\"id\":\"156692731543568\"},{\"name\":\"Yumi Chang\",\"id\":\"356955027974493\"},{\"name\":\"Chang  Jeffrey\",\"id\":\"670491706400075\"},{\"name\":\"Laddarat Chang-in\",\"id\":\"836717079750972\"},{\"name\":\"Christoph Change\",\"id\":\"270223456795399\"},{\"name\":\"Ji Chang Wook\",\"id\":\"325602860959878\"},{\"name\":\"Carrie  Chang\",\"id\":\"497421857064350\"},{\"name\":\"Nini Chang\",\"id\":\"10201094420077664\"},{\"name\":\"Ji Chang Wook\",\"id\":\"152123105345395\"},{\"name\":\"Ji Chang Wook\",\"id\":\"309036562888989\"},{\"name\":\"Chang Chang Miso\",\"id\":\"10204080564800231\"},{\"name\":\"Li-Tung Chang\",\"id\":\"524075951056087\"},{\"name\":\"Jimmy Chang\",\"id\":\"802937203050788\"},{\"name\":\"Ching Chang Fu\",\"id\":\"303985746729389\"},{\"name\":\"Susan Chang\",\"id\":\"1925731064348509\"},{\"name\":\"Yo-chang Chen\",\"id\":\"839089309438536\"},{\"name\":\"Pee Chang\",\"id\":\"696858213708340\"},{\"name\":\"Jewon  Chang\",\"id\":\"617496645006193\"},{\"name\":\"Jiho Chang\",\"id\":\"10152031488826762\"}]}"
        
        do {
            if let data = response.data(using: .utf8),
               let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
               let items = json["data"] as? [[String:Any]] {
                
                return Observable.just(
                    items.map {
                        item in
                        FBUser(item)
                    }
                )
            }
        } catch {
            print("failed to serialize json object")
        }
        
        return Observable.just([])
            .delay(1.0, scheduler: MainScheduler.instance)
    }
}

class FBGraphAPI {
    let connection: GraphRequestConnection
    
    static let shared = FBGraphAPI(
        connection: GraphRequestConnection()
    )
    
    init(connection: GraphRequestConnection) {
        self.connection = connection
    }
}
extension FBGraphAPI : FBGraphAPIProtocol {}
