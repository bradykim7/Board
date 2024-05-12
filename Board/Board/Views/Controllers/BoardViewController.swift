//
//  BoardViewController.swift
//  Board
//
//  Created by min seok Kim on 5/4/24.
//
import UIKit
import RxSwift
import RxCocoa

class BoardViewController: UIViewController {
    
    var tableView: UITableView!
    var viewModel = PostViewModel()
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindViewModel()
        viewModel.loadPosts()
    }
    
    func setupTableView() {
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }
    
    func bindViewModel() {
        viewModel.posts.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { (row, post, cell) in
                cell.textLabel?.text = post.title
            }
            .disposed(by: disposeBag)

        viewModel.errorMessage
            .subscribe(onNext: { [weak self] message in
                guard let message = message else { return }
                let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(alert, animated: true)
            })
            .disposed(by: disposeBag)
    }
}

