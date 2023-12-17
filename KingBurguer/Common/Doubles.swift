//
//  Doubles.swift
//  KingBurguer
//
//  Created by Leonardo Lamoia on 17/12/23.
//

import Foundation


extension Double {
    func toCurrency() -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "PT-BR")
        
        return formatter.string(from: self as NSNumber)
    }
}
