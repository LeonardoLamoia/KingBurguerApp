//
//  Views.swift
//  KingBurguer
//
//  Created by Leonardo Lamoia on 27/12/23.
//

import UIKit

extension UIView {
    
    func findViewByTag(tag: Int) -> UIView? {
        for subview in subviews {
            if subview.tag == tag {
                return subview
            }
        }
        return nil
    }
    
}
