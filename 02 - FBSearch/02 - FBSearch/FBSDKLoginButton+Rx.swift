//
//  LoginButton+Rx.swift
//  02 - FBSearch
//
//  Created by Tina Chang on 2017/7/13.
//  Copyright © 2017年 Tina Chang. All rights reserved.
//

import FBSDKLoginKit

#if !RX_NO_MODULE
import RxSwift
import RxCocoa
#endif

public class RxLoginButtonDelegateProxy : DelegateProxy, FBSDKLoginButtonDelegate, DelegateProxyType {

    public weak private(set) var loginButton: FBSDKLoginButton?
    public let loginedSubject = PublishSubject<Bool>()
    
    public required init(parentObject: AnyObject) {
        super.init(parentObject: parentObject)
    }
    
    deinit {
        loginedSubject.onCompleted()
    }
    
    // MARK: Delegate methods
    public func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        if error != nil {
            loginedSubject.onError(NSError(domain: "loginFailed", code: -1, userInfo: nil))
        } else if result.token != nil {
            loginedSubject.onNext(true)
        } else {
            loginedSubject.onNext(false)
        }
    }
    
    public func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        loginedSubject.onNext(false)
    }
    
    // MARK: Delegate proxy methods
    public class func currentDelegateFor(_ object: AnyObject) -> AnyObject? {
        let button: FBSDKLoginButton = castOrFatalError(object)
        return button.delegate as AnyObject?
    }
    
    public class func setCurrentDelegate(_ delegate: AnyObject?, toObject object: AnyObject) {
        let button: FBSDKLoginButton = castOrFatalError(object)
        button.delegate = castOptionalOrFatalError(delegate)
    }
    
}

extension Reactive where Base: FBSDKLoginButton {
    
    public var delegate: DelegateProxy {
        return RxLoginButtonDelegateProxy.proxyForObject(base)
    }
    
    public var logined: Observable<Bool> {
        return (delegate as! RxLoginButtonDelegateProxy)
            .loginedSubject
            .filter { $0 }
    }
    
}
