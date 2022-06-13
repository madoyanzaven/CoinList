//
//  MobileAPIClient.swift
//  CoinList
//
//  Created by Zaven Madoyan on 10.06.22.
//

import Foundation
import ReactiveSwift

class MobileAPIClient: APIClient {
    private var baseEndpointUrl: URL?
    private var session: URLSession?
    
    init(baseUrl: String, session: URLSession) {
        self.baseEndpointUrl = URL(string: baseUrl)!
        self.session = session
    }
    
    func send<T: APIRequesting>(_ request: T) -> SignalProducer<T.Response, Error> {
        let endpoint = baseEndpointUrl?.appendingPathComponent(request.resourceName)
        var apiRequest = URLRequest(url: endpoint!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        apiRequest.httpMethod = request.httpMethod
        if let queryParameter = request.queryParameter {
            try? MobileAPIClient.self.configureParameters(
                bodyParameters: request.bodyData as? BodyParameters,
                urlParameters: queryParameter,
                request: &apiRequest)
        }
        apiRequest.allHTTPHeaderFields = [
            "accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        return SignalProducer { (observer, disposable) in
            if let session = self.session {
                let task = session.dataTask(with: apiRequest) { data, response, error in
                    if let response = response as? HTTPURLResponse {
                        switch response.statusCode {
                            case 200:
                                if let data = data {
                                    do {
                                        let decoder = JSONDecoder()
                                        decoder.dateDecodingStrategy = .deferredToDate
                                        let apiResponse = try decoder.decode(T.Response.self, from: data)
                                        
                                        observer.send(value: apiResponse)
                                        observer.sendCompleted()
                                    } catch {
                                        observer.send(error: error)
                                    }
                                }
                            case 201:
                                observer.sendCompleted()
                            default:
                                print("Response: \(response)")
                                let err = NSError(domain: "", code: response.statusCode, userInfo: nil)
                                observer.send(error:err)
                        }
                    }
                    else if let error = error {
                        observer.send(error: error)
                    }
                }
                
                task.resume()
            }
        }
    }
    
    private func endpoint<T: APIRequesting>(for request: T) -> URL {
        guard let url = URL(string: request.resourceName, relativeTo: baseEndpointUrl) else {
            fatalError("Bad resourceName: \(request.resourceName)")
        }
        return url
    }
    
    class func configureParameters(
        bodyParameters: BodyParameters?,
        urlParameters: QueryParameters?,
        request: inout URLRequest) throws {
            do {
                if let urlParameters = urlParameters {
                    try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
                }
            } catch {
                throw error
            }
        }
}
