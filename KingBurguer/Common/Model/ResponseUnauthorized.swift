//
//  ResponseUnauthorized.swift
//  KingBurguer
//
//  Created by Leonardo Lamoia on 23/11/23.
//

import Foundation

struct ResponseUnauthorized: Decodable {
    
    let detail: ResponseDetail
    
    enum CodingKeys: String, CodingKey {
        case detail
    }
    
}

struct ResponseDetail: Decodable {
    
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case message
        
    }
    
}
