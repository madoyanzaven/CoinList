//
//  Constants.swift
//  CoinList
//
//  Created by Zaven Madoyan on 10.06.22.
//

import Foundation
import UIKit

enum Constants {}

extension Constants {
    static let baseUrl = "https://api.coin-stats.com"
    static let coinCellIdentifier = "CoinTableViewCell"
}

extension Constants {
    enum Collors {
        static var mainRed: UIColor? {
            return UIColor(named: "coinRed")
        }
        
        static var mainGreen: UIColor? {
            return UIColor(named: "coinGreen")
        }
        
        static var barItemGray: UIColor? {
            return UIColor(named: "barItemGray")
        }
    }
}


extension Constants {
    enum Icons {
        static var downArrow: UIImage? {
            return UIImage(named: "downArrow")
        }
        
        static var upArrow: UIImage? {
            return UIImage(named: "upArrow")
        }
        
        static var search: UIImage? {
            return UIImage(named: "search")
        }
    }
}
