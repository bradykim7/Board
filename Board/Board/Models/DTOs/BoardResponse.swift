//
//  BoardResponse.swift
//  Board
//
//  Created by min seok Kim on 5/12/24.
//

import Foundation

struct BoardResponse: Decodable {
    let value: [Board]
    let count: Int
    let offset: Int
    let limit: Int
    let total: Int
}
