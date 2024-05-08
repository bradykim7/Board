//
//  BoardViewModel.swift
//  Board
//
//  Created by min seok Kim on 5/4/24.
//

import RxSwift
import Moya

class PostViewModel {
    var provider = MoyaProvider<PostService>()
    var posts = PublishSubject<[Post]>()
    var disposeBag = DisposeBag()
    
    init() {
        fetchPosts()
    }

    func fetchPosts() {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601  // ISO8601 포맷이라고 가정

        provider.rx.request(.getPosts)
            .filterSuccessfulStatusCodes()
            .map([Post].self, using: decoder)
            .subscribe { event in
                switch event {
                case .success(let posts):
                    self.posts.onNext(posts)
                case .failure(let error):
                    print(error)
                }
            }.disposed(by: disposeBag)
    }
}
