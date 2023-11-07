//
//  Strings.swift
//  KingBurguer
//
//  Created by Leonardo Lamoia on 07/11/23.
//

import Foundation
import UIKit


extension String {
    
    func isEmail() -> Bool {
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        return NSPredicate(format: "SELF MATCHES %@", regEx).evaluate(with: self)
    }
}
