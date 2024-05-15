//
//  Board.swift
//  Board
//
//  Created by min seok Kim on 5/12/24.
//

import Foundation

// Example JSON
//{
//    "boardId": 28478, // 게시판 id
//    "displayName": "테스트 게시판", // 게시판 이름
//    "boardType": "normal", // 게시판 type (미사용)
//    "isFavorite": true, // 즐겨찾기 유무 (미사용)
//    "hasNewPost": false, // 새글 유무 (미사용)
//    "orderNo": 1, // (미사용)
//    "capability": { // (미사용)
//        "writable": true,
//        "manageable": true
//    }
//}

struct Board: Decodable {
    var id: Int
    var name: String
    var boardType: String
    var isFavorite: Bool
    var hasNewPost: Bool
    var orderNo: Int
    var capability: Capability
    
    
    enum CodingKeys: String, CodingKey {
        case id = "boardId"
        case name = "displayName"
        case boardType
        case isFavorite
        case hasNewPost
        case orderNo
        case capability
    }
}
