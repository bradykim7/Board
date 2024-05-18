//
//  BoardService.swift
//
//
//  Created by min seok Kim on 5/6/24.
//

import Moya
import Foundation

enum BoardService {
    case fetchBoards
    case fetchBoard(boardId: Int)
}

extension BoardService: TargetType {
    
    var baseURL: URL {
        return URL(string: MailplugAPI.getBase.path)!
    }
    
    var path: String {
        switch self {
            case.fetchBoards:
                return "/boards"
            case .fetchBoard(let boardId):
                return "/board/\(boardId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case  .fetchBoards, .fetchBoard:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case  .fetchBoards, .fetchBoard:
            let jsonString = """
            {
                "boardId": 28478, // 게시판 id
                "displayName": "테스트 게시판", // 게시판 이름
                "boardType": "normal", // 게시판 type (미사용)
                "isFavorite": true, // 즐겨찾기 유무 (미사용)
                "hasNewPost": false, // 새글 유무 (미사용)
                "orderNo": 1, // (미사용)
                "capability": { // (미사용)
                    "writable": true,
                    "manageable": true
                }
            """
            return Data(jsonString.utf8)
        }
        
    }
    
    var task: Task {
        switch self {
        case  .fetchBoards, .fetchBoard:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        let token = MailplugAPI.getToken.path
        
        return ["Content-Type": "application/json",
                           "Authorization": "Bearer \(token)"]
    }
    
}
