//
//  URLParameterEncoder.swift
//  CoinList
//
//  Created by Zaven Madoyan on 10.06.22.
//

import Foundation

protocol QueryParameterEncoder {
    static func encode(urlRequest: inout URLRequest,
                       with parameters: QueryParameters) throws
}

struct URLParameterEncoder: QueryParameterEncoder {
    static func encode(urlRequest: inout URLRequest,
                       with parameters: QueryParameters) throws {
        guard let url = urlRequest.url else { throw NetWorkError.missingURL }
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                urlComponents.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents.url
        }
    }
    
}
