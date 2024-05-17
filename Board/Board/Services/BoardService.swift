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
        var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MTU5MzIzMDMsImV4cCI6MTcxNTkzNDEwMywidXNlcm5hbWUiOiJnd25vMDFAZ3QwMS5teXBsdWcua3IiLCJzY29wZSI6WyJtYWlsIiwiYWRkcmVzc2Jvb2siLCJjYWxlbmRhciIsImJvYXJkIiwic21zIiwibWVzc2VuZ2VyIiwiZWFzIiwiZHJpdmUiLCJ3b3Jrbm90ZSIsIm9yZ2FuaXphdGlvbiIsInRhc2siLCJyZXNlcnZlIiwiYWRtaW4iLCJocm0iXSwic2VydmljZUlkIjoxNDQ2ODc3LCJnb29kcyI6IkdXX0RFREkiLCJhY2NvdW50TmFtZSI6Ilx1YWQwMFx1YjlhY1x1Yzc5MCIsImNsaWVudElQIjoiMjIwLjg1LjIxLjM1IiwianRpIjoiMDg0MCJ9.lU_Cq6cg6cvooHmf7ZdGOgpEgC6IFEa360gKpRbqX1E"
        
        return ["Content-Type": "application/json",
                           "Authorization": "Bearer \(token)"]
    }
    
}
