//
//  UpdatedCoinListResponse.swift
//  CoinList
//
//  Created by Zaven Madoyan on 12.06.22.
//

import Foundation

struct UpdatedCoinListResponse: Decodable {
    let coins: [CoinData]
}

struct CoinData: Decodable {
    var identifier: String?
    var rank: Double?
    var priceUSD : Double?
    var priceBTC: Double?
    var volumeLastDay: Double?
    var marketCapUSD: Double?
    var percentChangeForHour: Double?
    var percentChangeForDay: Double?
    var percentChangeForWeek: Double?
    
    init(from decoder: Decoder) throws {
        do {
            var nestedContainer = try decoder.unkeyedContainer()
            
            repeat {
                switch nestedContainer.currentIndex {
                    case 0:
                        self.identifier = try nestedContainer.decode(String.self)
                    case 1:
                        self.rank = try nestedContainer.decode(Double.self)
                    case 2:
                        self.priceUSD = try nestedContainer.decode(Double.self)
                    case 3:
                        self.priceBTC = try nestedContainer.decode(Double.self)
                    case 4:
                        self.volumeLastDay = try nestedContainer.decode(Double.self)
                    case 5:
                        self.marketCapUSD = try nestedContainer.decode(Double.self)
                    case 6:
                        self.percentChangeForHour = try nestedContainer.decode(Double.self)
                    case 7:
                        self.percentChangeForDay = try nestedContainer.decode(Double.self)
                    case 8:
                        self.percentChangeForWeek = try nestedContainer.decode(Double.self)
                    default: break
                }
            } while nestedContainer.currentIndex < 9
        }
    }
}
