//
//  Dates.swift
//  KingBurguer
//
//  Created by Leonardo Lamoia on 27/12/23.
//

import UIKit


extension Date {
    
    func toString(dateFormat: String = "yyyy-MM-dd") -> String {
        let dt = DateFormatter()
        dt.locale = Locale(identifier: "en_US_POSIX")
        dt.dateFormat = dateFormat
        return dt.string(from: self)
    }
}
