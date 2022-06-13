//
//  UpdateCoinListRequest.swift
//  CoinList
//
//  Created by Zaven Madoyan on 12.06.22.
//

import Foundation

struct UpdateCoinListRequest: APIRequesting {
    typealias Response = UpdatedCoinListResponse
    
    var resourceName: String {
        return "/v3/coins"
    }
    
    var queryParameter: [String : Any]? {
        return [
            "responseType": "array"
        ]
    }
}
