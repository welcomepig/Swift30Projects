//
//  FBGraphSearchItem.swift
//  02 - FBSearch
//
//  Created by Tina Chang on 2017/7/9.
//  Copyright © 2017年 Tina Chang. All rights reserved.
//

class FBGraphSearchItem {
    var name = ""
    var id = ""
    
    // TODO: init?
    init(_ json: [String: Any]) {
        guard let name = json["name"] as? String else {
            print("missing name")
            return;
        }
        
        guard let id = json["id"] as? String else {
            print("missing id")
            return;
        }
        
        self.name = name
        self.id = id
    }
}
