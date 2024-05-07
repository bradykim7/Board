//
//  BoardViewController.swift
//  Board
//
//  Created by min seok Kim on 5/4/24.
//

import UIKit
import RxSwift
//import RxCocoa

class BoardViewController: UIViewController {
    
    var tableView: UITableView!
    var viewModel = PostViewModel()
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindTableView()
    }

    private func setupUI() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }

    private func bindTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        // Bind posts to tableView
        viewModel.posts
            .bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { (row, post, cell) in
                cell.textLabel?.text = post.title
                cell.detailTextLabel?.text = "Views: \(post.viewCount)"
            }
            .disposed(by: disposeBag)

        // Subscribe to select item
        tableView.rx.modelSelected(Post.self)
            .subscribe(onNext: { [weak self] post in
                print("Selected post: \(post.title)")
            })
            .disposed(by: disposeBag)
    }
}

