//
//  BoardService.swift
//
//
//  Created by min seok Kim on 5/6/24.
//

import Moya
import Foundation

enum BoardService {
    case getBoard
}

extension BoardService: TargetType {
    
    var baseURL: URL {
        return URL(string: MailplugAPI.getBase.path)!
    }
    
    var path: String {
        switch self {
            case .getBoard:
            return MailplugAPI.getBoardDetails(boardId: 28478).path
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getBoard:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .getBoard:
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
            case .getBoard:
                return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MTUyMjg3NTYsImV4cCI6MTcxNTIzMDU1NiwidXNlcm5hbWUiOiJtYWlsdGVzdEB3NjUud2lyby5rciIsInNjb3BlIjpbIm1haWwiLCJhZGRyZXNzYm9vayIsImNhbGVuZGFyIiwiYm9hcmQiLCJzbXMiLCJtZXNzZW5nZXIiLCJlYXMiLCJkcml2ZSIsIndvcmtub3RlIiwib3JnYW5pemF0aW9uIiwiYWRtaW4iLCJocm0iXSwic2VydmljZUlkIjoxMDAwMDAwODgzLCJnb29kcyI6IkdXX0RFREkiLCJhY2NvdW50TmFtZSI6Ilx1YWQwMFx1YjlhY1x1Yzc5MCIsImNsaWVudElQIjoiMTkyLjE2OC4zLjExIiwianRpIjoiMmIxZSJ9.gU6YlKoOCisp_o6JiQD5iYSDUJYEswIrbPrUHlBS2Ek"
        
        return ["Content-Type": "application/json",
                           "Authorization": "Bearer \(token)"]
    }
    
}
