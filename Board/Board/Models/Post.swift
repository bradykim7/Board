//
//  Post.swift
//  Board
//
//  Created by min seok Kim on 5/4/24.
//

 

//"postId": 1593021, // 게시글 id
//"title": "공지", // 게시글 제목
//"boardId": 27854, // 게시판 id
//"boardDisplayName": "읽기권한only", // 게시판 이름
//"writer": {
//    "displayName": "작성자_TEST", // 게시글 작성자 이름
//    "emailAddress": "writerTest@mailplug.co.kr" // 게시글 작성자 이메일
//    "profileImage": "profile_1.png" // 게시글 작성자 이미지
//},
//"contents": "공지게시글입니다. \\n\\n안녕하세요. 만나서 반갑습니다.",
//"createdDateTime": "2023-06-05T03:31:22Z", // 게시글 작성 시간
//"viewCount": 11, // 게시글 읽음 count
//"isNewPost": false, // 게시글 새글 유무
//"hasInlineImage": true, // 게시글 이미지 유무
//"hasAttachment": true, // 게시글 첨부파일 유무
//"hasReply": false // 게시글 답글

import Foundation

struct Post: Decodable {
    
    var id: Int
    var title: String
    var boardId: Int
    var boardDisplayName: String
    var writer: Writer
    var body: String
    var createdAt: String
    var viewCount: Int
    var postType: String
    var isNewPost: Bool
    var hasInlineImage: Bool
    var hasReply: Bool
    var commentsCount: Int
    var attachmentsCount: Int
//    var attachments: [String]?
    var isAnonymous: Bool
    var isOwner: Bool
    var isNotify: Bool
    
    enum CodingKeys: String, CodingKey {
        case id = "postId"
        case title
        case boardId
        case boardDisplayName
        case writer
        case body = "contents"
        case createdAt = "createdDateTime"
        case viewCount
        case postType
        case isNewPost
        case hasInlineImage
        case hasReply
        case commentsCount
        case attachmentsCount
//        case attachments
        case isAnonymous
        case isOwner
        case isNotify
    }
}
