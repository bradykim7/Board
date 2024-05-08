//
//  BoardService.swift
//  
//
//  Created by min seok Kim on 5/6/24.
//

import Moya
import Foundation

enum PostService {
    case getPosts
}

extension PostService: TargetType {
    
    var baseURL: URL {
        return URL(string: MailplugAPI.getBase.path)!
    }
    
    var path: String {
        switch self {
            case .getPosts:
                return MailplugAPI.getAllPosts.path
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .getPosts:
                return .get
        }
    }
    
    var sampleData: Data {
        switch self {
            case .getPosts:
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
            case .getPosts:
                return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    
}
