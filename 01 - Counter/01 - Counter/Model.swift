//
//  Model.swift
//  01 - Counter
//
//  Created by Tina Chang on 2017/7/1.
//  Copyright © 2017年 Tina Chang. All rights reserved.
//

import Foundation

class Model : NSObject {
    static var counterMax: Int = 10

    private var _counter: Int = 0 {
        willSet (_newCounter) {
            if _newCounter == Model.counterMax - 1 {
                print("counter's maximum")
            }
        }
    }

    dynamic var counter: Int {
        get {
            return _counter
        }
        set (newCounter) {
            if newCounter < Model.counterMax {
                _counter = newCounter
            }
        }
    }
    
    func increase() {
        counter += 1
    }

    func reset() {
        counter = 0
    }
}
