//
//  CoinListRepository.swift
//  CoinList
//
//  Created by Zaven Madoyan on 10.06.22.
//

import ReactiveSwift
import Foundation

struct CoinListRepository {
    private static let client = NetWorkManager.sharedManager.getManager(.urlSession)
    
    static func getCoinList() -> SignalProducer<CoinListResponse, Error> {
        return client.send(CoinListRequest())
    }
    
    static func updateCoinList() -> SignalProducer<UpdatedCoinListResponse, Error> {
        return client.send(UpdateCoinListRequest())
    }
}
