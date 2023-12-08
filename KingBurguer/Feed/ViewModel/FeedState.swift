//
//  FeedState.swift
//  KingBurguer
//
//  Created by Leonardo Lamoia on 08/12/23.
//

import Foundation

enum FeedState {
    case loading
    case success(FeedResponse)
    case successHighlight(HighlightResponse)
    case error(String)
}
