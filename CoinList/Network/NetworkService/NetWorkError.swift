//
//  NetWorkError.swift
//  CoinList
//
//  Created by Zaven Madoyan on 10.06.22.
//

import Foundation

enum NetWorkError : String, Error {
    case parametersNil = "Parameteers were nil."
    case encodingFailed = "Parameteers encoding failed."
    case missingURL = "URL is nil."
}
