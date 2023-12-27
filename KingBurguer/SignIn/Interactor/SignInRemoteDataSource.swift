//
//  SignInRemoteDataSource.swift
//  KingBurguer
//
//  Created by Leonardo Lamoia on 30/11/23.
//

import Foundation
import UIKit


class SignInRemoteDataSource {
    
    static let shared = SignInRemoteDataSource()
    
    func login(request: SignInRequest, completion: @escaping (SignInResponse?, String?) -> Void) {
        WebServiceAPI.shared.call(path: .login, body: request, method: .post) { result in
            switch result {
            case .success(let data):
                guard let data = data else { return }
                let response = try? JSONDecoder().decode(SignInResponse.self, from: data)
                completion(response, nil)
                break
                
            case .failure(let error, let data):
                print("ERROR: \(error)")
                
                guard let data = data else { return }
                
                switch error {
                case .unauthorized:
                    let response = try? JSONDecoder().decode(ResponseUnauthorized.self, from: data)
                    completion(nil, response?.detail.message)
                    break
                    
                case .internalError:
                    completion(nil, String(data: data, encoding: .utf8))
                    break
                    
                    
                default:
                    let response = try? JSONDecoder().decode(ResponseError.self, from: data)
                    completion(nil, response?.detail)
                    break
                }
                break
            }
        }
    }
    
}
