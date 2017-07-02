//
//  ViewController.swift
//  01 - Counter
//
//  Created by Tina Chang on 2017/7/1.
//  Copyright © 2017年 Tina Chang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var increaseBtn: UIButton!
    @IBOutlet weak var resetBtn: UIButton!
    
    var viewModel: ViewModel!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        viewModel = ViewModel()
        viewModel.addObserver(self,
                              forKeyPath: "counterText",
                              options: .new,
                              context: nil)
        viewModel.addObserver(self,
                              forKeyPath: "isIncreaseBtnEnabled",
                              options: .new,
                              context: nil)
    }

    deinit {
        viewModel.removeObserver(self, forKeyPath: "counterText")
        viewModel.removeObserver(self, forKeyPath: "isIncreaseBtnEnabled")
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "counterText" {
            if let counterText = change?[NSKeyValueChangeKey.newKey] as? String {
                self.counterLabel.text = counterText
            }
        } else if keyPath == "isIncreaseBtnEnabled" {
            if let isEnabled = change?[NSKeyValueChangeKey.newKey] as? Bool {
                self.increaseBtn.isEnabled = isEnabled
            }
        }
    }

    @IBAction func increaseButtonDidTouch(sender: AnyObject) {
        viewModel.increaseButtonDidTouch()
    }

    @IBAction func resetButtonDidTouch(sender: AnyObject) {
        viewModel.resetButtonDidTouch()
    }
}

