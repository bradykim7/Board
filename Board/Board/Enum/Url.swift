//
//  Url.swift
//  Board
//
//  Created by min seok Kim on 5/6/24.
//

enum MailplugAPI {
    case getBase
    case getAllPosts
    case getPostDetails(postId: Int)

    var path: String {
        switch self {
        case .getBase:
            return "https://mp-dev.mail-server.kr/api/v2/boards"
        case .getAllPosts:
            return "\(MailplugAPI.getBase.path)/28478/posts"
        case .getPostDetails(let postId):
            return "\(MailplugAPI.getAllPosts.path)/\(postId)"
        }
    }
}

