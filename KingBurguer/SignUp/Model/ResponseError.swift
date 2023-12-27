//
//  SignUpResponseError.swift
//  KingBurguer
//
//  Created by Leonardo Lamoia on 22/11/23.
//

import Foundation


struct ResponseError: Decodable {
    let detail: String
    
    enum CodingKeys: String, CodingKey {
        case detail
        
    }
}
