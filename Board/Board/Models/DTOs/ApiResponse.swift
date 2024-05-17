//
//  ResponseImpl.swift
//  
//
//  Created by min seok Kim on 5/17/24.
//

import Foundation


struct ApiResponse<T: Decodable>: Decodable {
    
    let value: [T]
    let count: Int
    let offset: Int
    let limit: Int
    let total: Int
}
