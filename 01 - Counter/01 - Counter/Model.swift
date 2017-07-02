//
//  Model.swift
//  01 - Counter
//
//  Created by Tina Chang on 2017/7/1.
//  Copyright © 2017年 Tina Chang. All rights reserved.
//

import Foundation

class Model : NSObject {
    dynamic var counter = 0
    
    func increase() {
        counter += 1
    }

    func reset() {
        counter = 0
    }
}
