//
//  ParameterEncoding.swift
//  CoinList
//
//  Created by Zaven Madoyan on 10.06.22.
//

import Foundation

protocol BodyParameters: Codable {}

typealias QueryParameters = [String:Any]

protocol BodyParameterEncoder {
    static func encode(urlRequest: inout URLRequest,
                       with parameters: BodyParameters) throws
}
