//
//  LoginViewController.swift
//  02 - FBSearch
//
//  Created by Tina Chang on 2017/7/11.
//  Copyright © 2017年 Tina Chang. All rights reserved.
//

import UIKit
import FBSDKLoginKit

#if !RX_NO_MODULE
import RxSwift
#endif

class LoginViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = FBSDKLoginButton()
        loginButton.center = view.center
        loginButton.readPermissions = ["public_profile", "user_friends"]
        
        loginButton.rx.logined
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { _ in
                let mainVC = UIStoryboard(name: "Main", bundle: nil)
                    .instantiateViewController(withIdentifier: "MainVC")
                self.present(mainVC, animated: true, completion: nil)
            }).disposed(by: disposeBag)

        view.addSubview(loginButton)
    }

    
}
