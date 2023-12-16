//
//  ProductDetailState.swift
//  KingBurguer
//
//  Created by Leonardo Lamoia on 16/12/23.
//

import Foundation


enum ProductDetailState {
    case loading
    case success(ProductResponse)
    case error(String)
}
