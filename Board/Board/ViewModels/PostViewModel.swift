//
//  BoardViewModel.swift
//  Board
//
//  Created by min seok Kim on 5/4/24.
//

import Foundation
import Moya
import RxSwift
import RxCocoa

class PostViewModel {
    private let provider = MoyaProvider<PostService>()
    private let disposeBag = DisposeBag()

    var posts = BehaviorRelay<[Post]>(value: [])
    var errorMessage = PublishSubject<String?>()


    var onDataUpdated: (() -> Void)?
    var onErrorOccurred: (() -> Void)?


    func loadPosts() {
           provider.rx.request(.fetchPosts)
               .observe(on: MainScheduler.instance)
               .subscribe(onSuccess: { [weak self] response in
                   self?.handleSuccess(response)
               }, onFailure: { [weak self] error in
                   self?.handleError(error)
                   self?.loadSampleData()
               })
               .disposed(by: disposeBag)
       }

    private func handleSuccess(_ response: Response) {
            do {
                let postsResponse = try JSONDecoder().decode(PostResponse.self, from: response.data)
                posts.accept(postsResponse.value)
            } catch {
                errorMessage.onNext("Error decoding response: \(error)")
                loadSampleData()
            }
        }

    private func handleError(_ error: Error) {
        errorMessage.onNext("Network or decoding error: \(error.localizedDescription)")
    }

    private func loadSampleData() {
        do {
            let sampleData = try JSONDecoder().decode([Post].self, from: PostService.fetchPosts.sampleData)
            posts.accept(sampleData)
        } catch {
            errorMessage.onNext("Error decoding sample data: \(error)")
        }
    }
}

