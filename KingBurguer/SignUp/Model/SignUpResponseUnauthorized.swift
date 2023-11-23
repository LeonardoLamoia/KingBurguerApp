//
//  SignUpResponseUnauthorized.swift
//  KingBurguer
//
//  Created by Leonardo Lamoia on 22/11/23.
//

import Foundation


struct SignUpResponseUnauthorized: Decodable {
    
    let detail: SignUpResponseDetail
    
    enum CodingKeys: String, CodingKey {
        case detail
    }
    
}

struct SignUpResponseDetail: Decodable {
    
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case message
        
    }
    
}
