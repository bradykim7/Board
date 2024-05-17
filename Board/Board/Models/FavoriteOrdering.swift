//
//  favoriteOrdering.swift
//  Board
//
//  Created by min seok Kim on 5/17/24.
//

import Foundation

// Example JSON
//"favoriteOrdering": {
//    "sortDirection": "right",
//    "directionOrderNo": 0
//}

struct FavoriteOrdering: Decodable {
    
    var sortDirection: String
    var directionOrderNo: Int
    
    enum CodingKeys: String, CodingKey {
        case sortDirection
        case directionOrderNo
    }
}
