//
//  SignUpInteractor.swift
//  KingBurguer
//
//  Created by Leonardo Lamoia on 29/11/23.
//

import UIKit

class SignUpInteractor {
    
    private let remote: SignUpRemoteDataSource = .shared

    func createUser(request: SignUpRequest, completion: @escaping (Bool?, String?) -> Void ) {
        remote.createUser(request: request, completion: completion)
    }
}
