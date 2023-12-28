//
//  ProfileInteractor.swift
//  KingBurguer
//
//  Created by Leonardo Lamoia on 17/12/23.
//

import Foundation


class ProfileInteractor {
    
    private let remote: ProfileRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
    
    func fetch(completion: @escaping (UserResponse?, String?) -> Void ) {
        return remote.fetch(completion: completion)
    }
    
}
