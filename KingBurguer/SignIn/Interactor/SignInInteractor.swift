//
//  SignInInteractor.swift
//  KingBurguer
//
//  Created by Leonardo Lamoia on 30/11/23.
//

import Foundation
import UIKit


class SignInInteractor {
    
    private let remote: SignInRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
    
    func login(request: SignInRequest, completion: @escaping (SignInResponse?, String?) -> Void ) {
        remote.login(request: request) { response, error in
            
            if let r = response {
                
                let userAuth = UserAuth(accessToken: r.accessToken,                                        refreshToken: r.refreshToken,
                                        expiresSeconds: Int(Date().timeIntervalSince1970 + Double( r.expiresSeconds)),
                                        tokenType: r.tokenType)
                self.local.insetUserAuth(userAuth: userAuth)
            }
            completion(response, error)
        }
        
    }
}
