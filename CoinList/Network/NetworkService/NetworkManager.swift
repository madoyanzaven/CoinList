//
//  NetworkManager.swift
//  CoinList
//
//  Created by Zaven Madoyan on 10.06.22.
//

import Foundation

final class NetWorkManager {
    static let sharedManager = NetWorkManager()
    
    private init() {}
    
    func getManager(_ type: NetWorkManagerType) -> MobileAPIClient {
        switch type {
            case .urlSession:
                return  MobileAPIClient(baseUrl: Constants.baseUrl,
                                        session: URLSession.init(configuration: .default))
        }
    }
}

enum NetWorkManagerType {
    case urlSession
}
