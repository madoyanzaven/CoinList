//
//  APIRequesting.swift
//  CoinList
//
//  Created by Zaven Madoyan on 10.06.22.
//

import Foundation

protocol APIRequesting: Encodable {
    associatedtype Response: Decodable
    
    var resourceName: String { get }
    var httpMethod: String? { get }
    var bodyData: Encodable? { get }
    var queryParameter: [String: Any]? { get }
}

extension APIRequesting {
    var httpMethod: String? { return "GET" }
    var bodyData: Encodable? { return nil }
    var queryParameter: [String: Any]? { return [:] }
}
