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
        provider.rx.request(.getPosts)
            .filterSuccessfulStatusCodes()
            .map([Post].self)
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
