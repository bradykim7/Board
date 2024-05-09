//
//  BoardViewModel.swift
//  Board
//
//  Created by min seok Kim on 5/4/24.
//

import RxSwift
import Moya

class PostViewModel {
    private let provider = MoyaProvider<PostService>()
    var posts: [Post] = []
    var errorMessage: String?

    // UI 업데이트를 위한 클로저
    var onDataUpdated: (() -> Void)?
    var onErrorOccurred: (() -> Void)?

    func loadPosts() {
        provider.request(.fetchPosts) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let postsResponse = try JSONDecoder().decode(PostsResponse.self, from: response.data)
                    self?.posts = postsResponse.value
                    DispatchQueue.main.async {
                        self?.onDataUpdated?()
                    }
                } catch {
                    self?.loadSampleData() // 오류 발생 시 sampleData 로드
                }
            case .failure:
                self?.loadSampleData() // 요청 실패 시 sampleData 로드
            }
        }
    }

    private func loadSampleData() {
        do {
            self.posts = try JSONDecoder().decode([Post].self, from: PostService.fetchPosts.sampleData)
            DispatchQueue.main.async {
                self.onDataUpdated?()
            }
        } catch {
            self.errorMessage = "Error decoding sample data: \(error)"
            DispatchQueue.main.async {
                self.onErrorOccurred?()
            }
        }
    }
}

//
//import UIKit
//
//class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//    var tableView: UITableView!
//    var viewModel = PostViewModel()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
// 
//    init() {
//        fetchPosts()
//    }
//
//    func fetchPosts() {
//        let decoder = JSONDecoder()
//        decoder.dateDecodingStrategy = .iso8601  // ISO8601 포맷이라고 가정
//
//        provider.rx.request(.fetchPosts)
//            .filterSuccessfulStatusCodes()
//            .map([Post].self, using: decoder)
//            .subscribe { event in
//                switch event {
//                case .success(let posts):
//                    self.posts.onNext(posts)
//                case .failure(let error):
//                    print(error)
//                }
//            }.disposed(by: disposeBag)
//    }
//}
