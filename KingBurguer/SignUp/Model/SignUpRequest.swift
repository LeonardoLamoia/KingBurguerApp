//
//  SignUpRequest.swift
//  KingBurguer
//
//  Created by Leonardo Lamoia on 12/11/23.
//

import UIKit


struct SignUpRequest: Encodable {
    let name: String
    let email: String
    let password: String
    let document: String
    let birthday: String
    
    
    enum CodingKeys: String, CodingKey {
        case name = "name" // Exemplo de alteração de nome "chave"
        case email
        case password
        case document
        case birthday
    }
}
