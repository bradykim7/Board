//
//  Url.swift
//  Board
//
//  Created by min seok Kim on 5/6/24.
//

enum MailplugAPI {
    case getBase
    case getAllPosts
    case getBoards
    case getBoardDetails(boardId: Int)
    case getPostDetails(postId: Int)

    var path: String {
        switch self {
        case .getBase:
//            return "https://mp-dev.mail-server.kr/api/v2/boards"
//            return "https://bbs.wiro.kr/api/v2/boards"
            return "https://719166d8-4e43-4a1b-814a-949362b9afac.mock.pstmn.io/api/v2/boards"
        case .getBoards:
            return "https://719166d8-4e43-4a1b-814a-949362b9afac.mock.pstmn.io/api/v2/boards"
        case .getBoardDetails(let boardId):
            return "/\(boardId)"
        case .getAllPosts:
//            return "\(MailplugAPI.getBase.path)/28478/posts"
            return "/28478/posts"
        case .getPostDetails(let postId):
            return "/\(postId)"
        }
    }
}

