//
//  SignInResponse.swift
//  KingBurguer
//
//  Created by Leonardo Lamoia on 23/11/23.
//

import Foundation

struct SignInResponse: Decodable {
    let accessToken: String
    let refreshToken: String
    let expiresSeconds: Int
    let tokenType: String
    
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case expiresSeconds = "expires_seconds"
        case tokenType = "token_type"
    }
}


