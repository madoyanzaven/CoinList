//
//  APIClient.swift
//  CoinList
//
//  Created by Zaven Madoyan on 10.06.22.
//

import Foundation
import ReactiveSwift

protocol APIClient {
    func send<T: APIRequesting>(_ request: T) -> SignalProducer<T.Response, Error>
}
