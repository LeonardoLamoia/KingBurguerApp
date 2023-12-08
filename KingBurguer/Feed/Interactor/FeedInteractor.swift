//
//  FeedInteractor.swift
//  KingBurguer
//
//  Created by Leonardo Lamoia on 08/12/23.
//

import Foundation


class FeedInteractor {
    
    private let remote: FeedRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
    
    func fetch(completion: @escaping (FeedResponse?, String?) -> Void ) {
        let userAuth = local.getUserAuth()
        guard let accessToken = userAuth?.accessToken else {
            completion(nil, "Access token not found!")
            return
        }
        
       return remote.fetch(accessToken: accessToken, completion: completion)
        
    }
}
