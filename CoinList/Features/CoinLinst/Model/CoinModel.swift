//
//  CoinModel.swift
//  CoinList
//
//  Created by Zaven Madoyan on 10.06.22.
//

import Foundation

class CoinModel {
    var coin: Coin
    
    init(coin: Coin) {
        self.coin = coin
    }
    
    var hasNegativePercent: Bool {
        return percentChangeForDay < 0
    }
    
    var identifier: String {
        return coin.identifier
    }
    
    var name: String {
        return coin.name
    }
    
    var symbolText: String {
        return coin.symbol
    }
    
    var imageUrl: URL? {
        return URL(string: coin.iconUrl)
    }
    
    var rankText: String {
        return String(describing: Int(coin.rank ?? 0))
    }
    
    var priceUSDText: String {
        return "$ \(priceUSDValue)"
    }
    
    var percentValueText: String {
        return "\(percentValue)%"
    }
    
    private var priceUSDValue: Double {
        return coin.priceUSD ?? 0
    }
    
    private var percentValue: String {
        let percentAbsValue = abs(percentChangeForDay)
        
        return String(format: "%.2f", percentAbsValue)
    }
    
    private var percentChangeForDay: Double {
        return coin.percentChangeForDay ?? 0
    }
}
