//
//  MainViewModel.swift
//  02 - FBSearch
//
//  Created by Tina Chang on 2017/7/9.
//  Copyright © 2017年 Tina Chang. All rights reserved.
//

#if !RX_NO_MODULE
import RxSwift
#endif

class MainViewModel {
    let searchResult: Observable<[FBGraphSearchItem]>
    
    init(searchText: Observable<String>, API: FBGraphAPIProtocol) {
        searchResult = searchText
            .debounce(0.3, scheduler: MainScheduler.instance)   // delay input
            .distinctUntilChanged()                             // only emit distinct input
            .filter { $0 != "" }                                // filter empty input
            .flatMapLatest { query in
                return API.search(query, type: "user")
                    .observeOn(MainScheduler.instance)
                    .catchErrorJustReturn([])
            }
            .shareReplay(1)
    }
}
