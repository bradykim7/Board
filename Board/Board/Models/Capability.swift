//
//  Capability.swift
//  Board
//
//  Created by min seok Kim on 5/12/24.
//

import Foundation


// Example JSON
//    "capability": { // (미사용)
//        "writable": true,
//        "manageable": true
//    }
//}

struct Capability: Decodable {
    var writable: Bool
    var manageable: Bool
    
    enum CodingKeys: String, CodingKey {
        case writable
        case manageable
    }
}
