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
    var posts: [Post] = [
        
    ]


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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return posts.count
        }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let post = posts[indexPath.row]
        cell.textLabel?.text = post.title
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // 여기서 게시글을 탭했을 때의 동작을 추가할 수 있습니다.
    }

    private func bindTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        // Bind posts to tableView 아래 코드가 발전코드
//        viewModel.posts
//            .bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { (row, post, cell) in
//                cell.textLabel?.text = post.title
//                cell.detailTextLabel?.text = "Views: \(post.viewCount)"
//            }
//            .disposed(by: disposeBag)
//
//        // Subscribe to select item
//        tableView.rx.modelSelected(Post.self)
//            .subscribe(onNext: { [weak self] post in
//                print("Selected post: \(post.title)")
//            })
//            .disposed(by: disposeBag)
    }
}

