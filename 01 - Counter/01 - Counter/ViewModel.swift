//
//  ViewModel.swift
//  01 - Counter
//
//  Created by Tina Chang on 2017/7/1.
//  Copyright © 2017年 Tina Chang. All rights reserved.
//

import Foundation

class ViewModel: NSObject {
    dynamic var counterText: String {
        get {
            return String(model.counter)
        }
    }

    dynamic var isIncreaseBtnEnabled: Bool {
        get {
            return (model.counter < 9)
        }
    }

    var model: Model!

    override init() {
        super.init()
        
        model = Model()
        model.addObserver(self,
            forKeyPath: "counter",
            options: .new,
            context: nil)
    }

    deinit {
        model.removeObserver(self, forKeyPath: "counter")
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "counter" {
            if ((change?[NSKeyValueChangeKey.newKey] as? Int) != nil) {
                self.willChangeValue(forKey: "counterText")
                self.willChangeValue(forKey: "isIncreaseBtnEnabled")

                self.didChangeValue(forKey: "counterText")
                self.didChangeValue(forKey: "isIncreaseBtnEnabled")
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
