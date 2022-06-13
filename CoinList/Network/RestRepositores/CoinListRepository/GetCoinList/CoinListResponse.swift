//
//  CoinListResponse.swift
//  CoinList
//
//  Created by Zaven Madoyan on 10.06.22.
//

import Foundation

struct CoinListResponse: Decodable {
    let coins: [Coin]
}

struct Coin: Decodable {
    let identifier: String
    let iconUrl: String
    let name: String
    let symbol: String
    let rank: Double?
    var priceUSD: Double?
    let priceBTC: Double?
    let volumeLastDay: Double?
    let marketCapUSD: Double?
    let percentChangeForHour: Double?
    let percentChangeForDay: Double?
    let percentChangeForWeek: Double?
    
    enum CodingKeys: String, CodingKey {
        case identifier = "i"
        case iconUrl = "ic"
        case name = "n"
        case symbol = "s"
        case rank = "r"
        case priceUSD = "pu"
        case priceBTC = "pb"
        case volumeLastDay = "v"
        case marketCapUSD = "m"
        case percentChangeForHour = "p1"
        case percentChangeForDay = "p24"
        case percentChangeForWeek = "p7"
    }
}
