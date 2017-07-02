//
//  ViewModel.swift
//  01 - Counter
//
//  Created by Tina Chang on 2017/7/1.
//  Copyright © 2017年 Tina Chang. All rights reserved.
//

import Foundation

class ViewModel : NSObject {
    dynamic var counterText: String!
    var model: Model!
    
    override init() {
        super.init()
        
        model = Model()
        model.addObserver(self,
            forKeyPath: "counter",
            options: .new,
            context: nil)
        
        counterText = String(model.counter)
    }
    
    deinit {
        model.removeObserver(self, forKeyPath: "counter")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "counter" {
            if let counter = change?[NSKeyValueChangeKey.newKey] as? Int {
                counterText = String(counter)
            }
        }
    }
    
    func increaseButtonDidTouch() {
        model.increase()
    }
    
    func resetButtonDidTouch() {
        model.reset()
    }
}
