//
//  BoardService.swift
//  
//
//  Created by min seok Kim on 5/6/24.
//

import Moya
import Foundation

enum PostService {
    case fetchPosts(boardId: Int)
    case searchPosts(boardId: Int, keyword: String, target: SearchTarget)
}

extension PostService: TargetType {
    
    var baseURL: URL {
        return URL(string: MailplugAPI.getBase.path)!
    }
    
    var path: String {
        switch self {
        case .fetchPosts(let boardId):
            return "/board/\(boardId)/posts"
        case .searchPosts(let boardId, _, _):
            return "/board/\(boardId)/posts"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchPosts, .searchPosts:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .fetchPosts:
            let jsonString = """
            [
                {
                    "postId": 1593021,
                    "title": "공지",
                    "boardId": 27854,
                    "boardDisplayName": "읽기권한only",
                    "writer": {
                        "displayName": "작성자_TEST",
                        "emailAddress": "writerTest@mailplug.co.kr",
                        "profileImage": "profile_1.png"
                    },
                    "contents": "공지게시글입니다. \\n\\n안녕하세요. 만나서 반갑습니다.",
                    "createdDateTime": "2023-06-05T03:31:22Z",
                    "viewCount": 11,
                    "isNewPost": false,
                    "hasInlineImage": true,
                    "hasAttachment": true,
                    "hasReply": false
                },
                {
                    "postId": 1593022,
                    "title": "공지2",
                    "boardId": 27854,
                    "boardDisplayName": "읽기권한only",
                    "writer": {
                        "displayName": "작성자2_TEST",
                        "emailAddress": "writerTest2@mailplug.co.kr",
                        "profileImage": "profile_2.png"
                    },
                    "contents": "공지게시글2입니다. \\n\\n안녕하세요. 만나서 반갑습니다.",
                    "createdDateTime": "2023-06-06T03:31:22Z",
                    "viewCount": 1,
                    "isNewPost": false,
                    "hasInlineImage": true,
                    "hasAttachment": true,
                    "hasReply": false
                }
            ]
            """
            return Data(jsonString.utf8)
            
        case .searchPosts:
            let jsonString = """
            [
                {
                    "postId": 1593021,
                    "title": "공지",
                    "boardId": 27854,
                    "boardDisplayName": "읽기권한only",
                    "writer": {
                        "displayName": "작성자_TEST",
                        "emailAddress": "writerTest@mailplug.co.kr",
                        "profileImage": "profile_1.png"
                    },
                    "contents": "공지게시글입니다. \\n\\n안녕하세요. 만나서 반갑습니다.",
                    "createdDateTime": "2023-06-05T03:31:22Z",
                    "viewCount": 11,
                    "isNewPost": false,
                    "hasInlineImage": true,
                    "hasAttachment": true,
                    "hasReply": false
                }
            ]
            """
            return Data(jsonString.utf8)
        }
    }
    
    var task: Task {
        switch self {
        case .fetchPosts:
            return .requestPlain
        case .searchPosts(_, let keyword, let target):
            let parameters: [String: Any] = [
                "search": keyword,
                "searchTarget": target,
                // TODO offset limit 바꿔야함.
                "offset": 0,
                "limit": 20
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MTU5MzIzMDMsImV4cCI6MTcxNTkzNDEwMywidXNlcm5hbWUiOiJnd25vMDFAZ3QwMS5teXBsdWcua3IiLCJzY29wZSI6WyJtYWlsIiwiYWRkcmVzc2Jvb2siLCJjYWxlbmRhciIsImJvYXJkIiwic21zIiwibWVzc2VuZ2VyIiwiZWFzIiwiZHJpdmUiLCJ3b3Jrbm90ZSIsIm9yZ2FuaXphdGlvbiIsInRhc2siLCJyZXNlcnZlIiwiYWRtaW4iLCJocm0iXSwic2VydmljZUlkIjoxNDQ2ODc3LCJnb29kcyI6IkdXX0RFREkiLCJhY2NvdW50TmFtZSI6Ilx1YWQwMFx1YjlhY1x1Yzc5MCIsImNsaWVudElQIjoiMjIwLjg1LjIxLjM1IiwianRpIjoiMDg0MCJ9.lU_Cq6cg6cvooHmf7ZdGOgpEgC6IFEa360gKpRbqX1E"
        
        return ["Content-Type": "application/json",
                           "Authorization": "Bearer \(token)"]
    }
    
}

