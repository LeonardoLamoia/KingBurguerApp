//
//  LocalDataSource.swift
//  KingBurguer
//
//  Created by Leonardo Lamoia on 30/11/23.
//

import UIKit

class LocalDataSource {

    static let shared = LocalDataSource()
    
    func insetUserAuth(userAuth: UserAuth) {
        let value = try? PropertyListEncoder().encode(userAuth)
        UserDefaults.standard.setValue(value, forKey: "user_key")
    }
    
    func getUserAuth() -> UserAuth? {
        if let data = UserDefaults.standard.value(forKey: "user_key") as? Data {
            let user = try? PropertyListDecoder().decode(UserAuth.self, from: data)
            return user
        }
        return nil
    }
    
}
