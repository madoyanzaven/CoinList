//
//  CoinListRequest.swift
//  CoinList
//
//  Created by Zaven Madoyan on 10.06.22.
//

import Foundation

struct CoinListRequest: APIRequesting {
    typealias Response = CoinListResponse
    
    var resourceName: String {
        return "/v3/coins"
    }
}

