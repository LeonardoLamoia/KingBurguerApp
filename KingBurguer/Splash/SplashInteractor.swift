//
//  SplashInteractor.swift
//  KingBurguer
//
//  Created by Leonardo Lamoia on 04/12/23.
//

import Foundation


class SplashInteractor {
    private let remote: SplashRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
    
    func login(request: SplashRequest, completion: @escaping (SignInResponse?, Bool) -> Void ) {
        let userAuth = local.getUserAuth()
        guard let accessToken = userAuth?.accessToken else {
            completion(nil, true)
            return
        }
        remote.login(request: request, accessToken: accessToken) { response, error in
            
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
