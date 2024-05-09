//
//  BoardViewController.swift
//  Board
//
//  Created by min seok Kim on 5/4/24.
//

import UIKit
import RxSwift
import RxCocoa
import Moya

class BoardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var tableView: UITableView!
    var viewModel = PostViewModel()
    var disposeBag = DisposeBag()
    var posts: [Post] = []
    let provider = MoyaProvider<PostService>()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindViewModel()
        viewModel.loadPosts()
    }
    
    func setupTableView() {
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }
    
    func bindViewModel() {
        viewModel.onDataUpdated = { [weak self] in
          self?.tableView.reloadData()
        }

        viewModel.onErrorOccurred = { [weak self] in
          let alert = UIAlertController(title: "Error", message: self?.viewModel.errorMessage, preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "OK", style: .default))
          self?.present(alert, animated: true)
        }
      }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return viewModel.posts.count
      }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
      cell.textLabel?.text = viewModel.posts[indexPath.row].title
      return cell
    }

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        // 여기서 게시글을 탭했을 때의 동작을 추가할 수 있습니다.
//    }
}
