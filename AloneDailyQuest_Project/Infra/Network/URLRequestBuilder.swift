//
//  URLRequestBuilder.swift
//  AloneDailyQuest_Project
//
//  Created by Wooseok on 5/7/24.
//

import Foundation

struct URLRequestBuilder {
    private let baseURL: String
    private var path: String = "/"
    private var headerParameters: [String: String] = [:]
    private var queryParameters: [String: String] = [:]
    private var method: HTTPMethod = .get
    private var bodyParameters: Encodable?
    private let encoder: JSONEncoder = JSONEncoder()
    
    init(baseURL: String
     ) {
        self.baseURL = baseURL
    }
}

extension URLRequestBuilder {
    private func buildURL() -> URL? {
        var components = URLComponents()
        components.scheme = URLScheme.http.rawValue
        components.host = baseURL
        components.path = path
        components.queryItems = queryParameters.map { URLQueryItem(name: $0, value: $1) }
        return components.url
    }
    
    func build() -> URLRequest? {
        guard let url = buildURL() else {
            return nil
        }
        var urlRequest = URLRequest(url: url)
        if let body = bodyParameters {
            urlRequest.httpBody = try? encoder.encode(body)
        }
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headerParameters
        return urlRequest
    }
    
    func setPath(_ path: String) -> Self {
        var builder = clone()
        builder.path = path
        return builder
    }
    
    func setHeaderParameters(_ headerParameters: [String: String]) -> Self {
        var builder = clone()
        builder.headerParameters = headerParameters
        return builder
    }
    
    func setQueryParameters(_ queryParameters: [String: String]) -> Self {
        var builder = clone()
        builder.queryParameters = queryParameters
        return builder
    }
    
    func setMethod(_ method: HTTPMethod) -> Self {
        var builder = clone()
        builder.method = method
        return builder
    }
    
    func setBodyParameters(_ bodyParameters: Encodable?) -> Self {
        var builder = clone()
        builder.bodyParameters = bodyParameters
        return builder
    }
    
    private func clone() -> Self {
        return .init(baseURL: self.baseURL,
                     path: self.path,
                     headerParameters: self.headerParameters,
                     queryParameters: self.queryParameters,
                     method: self.method,
                     bodyParameters: self.bodyParameters)
    }
    
    private init(
        baseURL: String,
        path: String,
        headerParameters: [String: String],
        queryParameters: [String: String],
        method: HTTPMethod,
        bodyParameters: Encodable?
    ) {
        self.baseURL = baseURL
        self.path = path
        self.headerParameters = headerParameters
        self.queryParameters = queryParameters
        self.method = method
        self.bodyParameters = bodyParameters
    }
    
}
