//
//  BoardService.swift
//  
//
//  Created by min seok Kim on 5/6/24.
//

import Moya
import Foundation

enum PostService {
    case fetchPosts
}

extension PostService: TargetType {
    
    var baseURL: URL {
        return URL(string: MailplugAPI.getBase.path)!
    }
    
    var path: String {
        switch self {
            case .fetchPosts:
                return MailplugAPI.getAllPosts.path
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchPosts:
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
        }
        
    }
    
    var task: Task {
        switch self {
            case .fetchPosts:
                return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MTUyMjg3NTYsImV4cCI6MTcxNTIzMDU1NiwidXNlcm5hbWUiOiJtYWlsdGVzdEB3NjUud2lyby5rciIsInNjb3BlIjpbIm1haWwiLCJhZGRyZXNzYm9vayIsImNhbGVuZGFyIiwiYm9hcmQiLCJzbXMiLCJtZXNzZW5nZXIiLCJlYXMiLCJkcml2ZSIsIndvcmtub3RlIiwib3JnYW5pemF0aW9uIiwiYWRtaW4iLCJocm0iXSwic2VydmljZUlkIjoxMDAwMDAwODgzLCJnb29kcyI6IkdXX0RFREkiLCJhY2NvdW50TmFtZSI6Ilx1YWQwMFx1YjlhY1x1Yzc5MCIsImNsaWVudElQIjoiMTkyLjE2OC4zLjExIiwianRpIjoiMmIxZSJ9.gU6YlKoOCisp_o6JiQD5iYSDUJYEswIrbPrUHlBS2Ek"
        
        return ["Content-Type": "application/json",
                           "Authorization": "Bearer \(token)"]
    }
    
}
