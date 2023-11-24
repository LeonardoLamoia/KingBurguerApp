//
//  SignInRequest.swift
//  KingBurguer
//
//  Created by Leonardo Lamoia on 23/11/23.
//

import Foundation


struct SignInRequest: Encodable {
    let username: String
    let password: String

    
    enum CodingKeys: String, CodingKey {
        case username
        case password
       
    }
}
