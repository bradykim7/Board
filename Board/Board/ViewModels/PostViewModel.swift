//
//  PostViewModel.swift
//
//
//  Created by min seok Kim on 5/17/24.
//

import Foundation
import Moya
import RxSwift
import RxCocoa

class PostViewModel: ViewModel<Post, PostService> {
    
    func loadPosts() {
        loadData(request: PostService.fetchPosts(boardId: 28478), sampleData: PostService.fetchPosts(boardId: 28478).sampleData)
    }
    
    func searchPosts(keyword: String, target: SearchTarget) {
        loadData(request: PostService.searchPosts(boardId: 28478, keyword: keyword, target: target), sampleData: PostService.searchPosts(boardId: 28478, keyword: keyword, target: target).sampleData)
    }
}
