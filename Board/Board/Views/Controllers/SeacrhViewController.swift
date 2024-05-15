//
//  SeacrhViewController.swift
//  Board
//
//  Created by Minseok Brady Kim on 5/15/24.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController {
    
    var searchController: UISearchController!
    private let disposeBag = DisposeBag()
    
    var searchTextObservable: Observable<String> {
        return searchController.searchBar.rx.text.orEmpty.asObservable()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
    }
    
    private func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Posts"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}
