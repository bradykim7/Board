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
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
        loadPosts()
    }

    func loadPosts() {
           provider.request(.fetchPosts) { result in
               switch result {
               case .success(let response):
                 do {
                     self.posts = try JSONDecoder().decode([Post].self, from: PostService.fetchPosts.sampleData)
//                     self.posts = try JSONDecoder().decode([Post].self, from: response.data)
                     self.tableView.reloadData()
                 } catch let error {
                     self.tableView.reloadData()
//                     print("Error decoding data: \(error)")
                 }
               case .failure(let error):
                   do {
                       self.posts = try JSONDecoder().decode([Post].self, from: PostService.fetchPosts.sampleData)
                       self.tableView.reloadData()
                   } catch {
                       print("Error decoding sample data: \(error)")
                   }
               }
           }
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

