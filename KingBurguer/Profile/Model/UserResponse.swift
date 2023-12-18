//
//  UserResponse.swift
//  KingBurguer
//
//  Created by Leonardo Lamoia on 17/12/23.
//

import Foundation


struct UserResponse: Decodable {
    
    let id: Int
    let name: String
    let email: String
    let document: String
    let birthday: String
    
}
