//
//  API.swift
//  AloneDailyQuest_Project
//
//  Created by Wooseok on 5/7/24.
//

import Foundation

enum API {
    case signup(userId: UserIdRequestDTO)
    case checkId(userId: UserIdRequestDTO)
    case login(userId: UserIdRequestDTO)
    case member(userId: UserIdRequestDTO)
    case experience(userId: UserIdRequestDTO)
    case addExperience(user: UserInfoDTO)
    case ranking
    case myRanking(userId: UserIdRequestDTO)
}

extension API {
    func toURLRequest() -> URLRequest? {
        let header = [
            API.contentTypeKey: API.contentType
        ]
        
        switch self {
        case .signup(let userId):
            return URLRequestBuilder(baseURL: API.baseURL)
                .setMethod(.post)
                .setHeaderParameters(header)
                .setPath("/signup")
                .setBodyParameters(userId)
                .build()
        case .checkId(let userId):
            return URLRequestBuilder(baseURL: API.baseURL)
                .setMethod(.post)
                .setHeaderParameters(header)
                .setPath("/check_id")
                .setBodyParameters(userId)
                .build()
        case .login(let userId):
            return URLRequestBuilder(baseURL: API.baseURL)
                .setMethod(.post)
                .setHeaderParameters(header)
                .setPath("/login")
                .setBodyParameters(userId)
                .build()
        case .member(let userId):
            return URLRequestBuilder(baseURL: API.baseURL)
                .setMethod(.get)
                .setPath("/member/\(userId.userId)")
                .build()
        case .experience(let userId):
            return URLRequestBuilder(baseURL: API.baseURL)
                .setMethod(.get)
                .setPath("/experience/\(userId.userId)")
                .build()
        case .addExperience(let user):
            return URLRequestBuilder(baseURL: API.baseURL)
                .setMethod(.post)
                .setHeaderParameters(header)
                .setPath("/add_experience")
                .setBodyParameters(user)
                .build()
        case .ranking:
            return URLRequestBuilder(baseURL: API.baseURL)
                .setMethod(.get)
                .setPath("/ranking")
                .build()
        case .myRanking(let userId):
            return URLRequestBuilder(baseURL: API.baseURL)
                .setMethod(.get)
                .setPath("/ranking/\(userId.userId)")
                .build()
        }
    }
}

extension API {
    private static let baseURL = "wooseokjang.shop"
    private static let contentTypeKey = "Content-Type"
    private static let contentType = "application/json"
}
