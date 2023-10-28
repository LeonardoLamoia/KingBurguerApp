//
//  SignUpState.swift
//  KingBurguer
//
//  Created by Leonardo Lamoia on 28/10/23.
//

import Foundation
import UIKit


enum SignUpState {
    case none
    case loading
    case goToHome
    case error(String)
}
