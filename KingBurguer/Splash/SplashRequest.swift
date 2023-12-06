//
//  SplashRequest.swift
//  KingBurguer
//
//  Created by Leonardo Lamoia on 04/12/23.
//

import Foundation

struct SplashRequest: Encodable {
    
    let refreshToken: String

    enum CodingKeys: String, CodingKey {
      case refreshToken = "refresh_token"
       
    }
}
