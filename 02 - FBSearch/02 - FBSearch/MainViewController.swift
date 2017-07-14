//
//  MainViewController.swift
//  02 - FBSearch
//
//  Created by Tina Chang on 2017/7/4.
//  Copyright © 2017年 Tina Chang. All rights reserved.
//

import UIKit

#if !RX_NO_MODULE
import RxSwift
import RxCocoa
#endif

class MainViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewModel = MainViewModel(
            searchText: searchBar.rx.text.orEmpty.asObservable(),
            API: FBGraphAPI.shared
        )
        
        viewModel.searchResult
            .bind(to: tableView.rx.items) { (tableView, row, item) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = item.name
                return cell
            }
            .disposed(by: disposeBag)
    }
    
}

