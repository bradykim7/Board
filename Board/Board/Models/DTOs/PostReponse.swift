//
//  PostReponse.swift
//  Board
//
//  Created by min seok Kim on 5/9/24.
//

import Foundation


struct PostResponse: Decodable {
    
    let value: [Post]
    let count: Int
    let offset: Int
    let limit: Int
    let total: Int
}
