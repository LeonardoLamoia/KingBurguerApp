//
//  SignInState.swift
//  KingBurguer
//
//  Created by Leonardo Lamoia on 07/10/23.
//

import Foundation


enum SignInState {
    case none
    case loading
    case goToHome
    case error(String)
}
