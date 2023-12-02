//
//  UserAuth.swift
//  KingBurguer
//
//  Created by Leonardo Lamoia on 30/11/23.
//

import Foundation


struct UserAuth: Codable {
    
    let accessToken: String
    let refreshToken: String
    let expiresSeconds: Int
    let tokenType: String
}
