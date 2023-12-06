//
//  SplashRemoteDataSource.swift
//  KingBurguer
//
//  Created by Leonardo Lamoia on 04/12/23.
//

import Foundation

class SplashRemoteDataSource {
    
    static let shared = SplashRemoteDataSource()
    
    func login(request: SplashRequest, accessToken: String, completion: @escaping (SignInResponse?, Bool) -> Void) {
        WebServiceAPI.shared.call(path: .refreshToken, body: request, method: .put, accessToken: accessToken) { result in
            switch result {
            case .success(let data):
                guard let data = data else { return }
                let response = try? JSONDecoder().decode(SignInResponse.self, from: data)
                completion(response, false)
                break
                
            case .failure(let error, let data):
                print("ERROR: \(error)")
                
               completion(nil, true)
                
                break
            }
        }
    }
    
}
