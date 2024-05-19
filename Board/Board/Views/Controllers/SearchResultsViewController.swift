//
//  SearchResultsViewController.swift
//  Board
//
//  Created by Minseok Brady Kim on 5/19/24.
//

import UIKit
import RxSwift
import RxCocoa

class SearchResultsViewController: UIViewController {
    
    var viewModel: PostViewModel!
    private let tableView = UITableView()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindViewModel()
    }
    
   
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.register(PostCell.self, forCellReuseIdentifier: "PostCell")
        tableView.rowHeight = 56
    }
    
    private func bindViewModel() {
        viewModel.dataObservable
            .bind(to: tableView.rx.items(cellIdentifier: "PostCell", cellType: PostCell.self)) { (row, post, cell) in
                cell.configure(with: post)
            }
            .disposed(by: disposeBag)
    }
    
}
