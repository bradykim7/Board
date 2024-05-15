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

    private var postRelay: BehaviorRelay<[Post]> = BehaviorRelay<[Post]>(value: [])
    private var errorMessageSubject: PublishSubject<String?> = PublishSubject<String?>()
    
    var postObservable: Observable<[Post]> {
        return postRelay.asObservable()
    }
    
    var errorMessageObservable: Observable<String?> {
        return errorMessageSubject.asObservable()
    }
    
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
    
    func searchPosts(keyword: String, searchTarget: SearchTarget) {
        provider.rx.request(.searchPosts(keyword: keyword, target: searchTarget))
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
                postRelay.accept(postsResponse.value)
            } catch {
                errorMessageSubject.onNext("Error decoding response: \(error)")
                loadSampleData()
            }
    }

    private func handleError(_ error: Error) {
        errorMessageSubject.onNext("Network or decoding error: \(error.localizedDescription)")
    }

    private func loadSampleData() {
        do {
            let sampleData = try JSONDecoder().decode([Post].self, from: PostService.fetchPosts.sampleData)
            postRelay.accept(sampleData)
        } catch {
            errorMessageSubject.onNext("Error decoding sample data: \(error)")
        }
    }
}

