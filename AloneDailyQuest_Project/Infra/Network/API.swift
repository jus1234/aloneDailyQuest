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
    case member(userId: UserIdRequestDTO)
    case experience(userId: UserIdRequestDTO)
    case addExperience(user: UserInfoDTO)
    case ranking
    case myRanking(userId: UserIdRequestDTO)
}

extension API {
    func toURLRequest() -> URLRequest? {
        switch self {
        case .signup(let userId):
            return makeSignUpAPI(userId: userId)
        case .checkId(let userId):
            return makeCheckId(userId: userId)
        case .member(let userId):
            return makeMemberAPI(userId: userId)
        case .experience(let userId):
            return makeExperienceAPI(userId: userId)
        case .addExperience(let user):
            return makeAddExperienceAPI(user: user)
        case .ranking:
            return makeRankingAPI()
        case .myRanking(let userId):
            return makeMyRankingAPI(userId: userId)
        }
    }
    
    private func makeSignUpAPI(userId: UserIdRequestDTO) -> URLRequest? {
        return URLRequestBuilder(baseURL: API.baseURL)
            .setMethod(.post)
            .setHeaderParameters(API.header)
            .setPath("/signup")
            .setBodyParameters(userId)
            .build()
    }
    
    private func makeCheckId(userId: UserIdRequestDTO) -> URLRequest? {
        return URLRequestBuilder(baseURL: API.baseURL)
            .setMethod(.post)
            .setHeaderParameters(API.header)
            .setPath("/check_id")
            .setBodyParameters(userId)
            .build()    }
    
    private func makeMemberAPI(userId: UserIdRequestDTO) -> URLRequest? {
        return URLRequestBuilder(baseURL: API.baseURL)
            .setMethod(.get)
            .setPath("/member/\(userId.userId)")
            .build()
    }
    
    private func makeExperienceAPI(userId: UserIdRequestDTO) -> URLRequest? {
        return URLRequestBuilder(baseURL: API.baseURL)
            .setMethod(.get)
            .setPath("/experience/\(userId.userId)")
            .build()
    }
    
    private func makeAddExperienceAPI(user: UserInfoDTO) -> URLRequest? {
        return URLRequestBuilder(baseURL: API.baseURL)
            .setMethod(.post)
            .setHeaderParameters(API.header)
            .setPath("/add_experience")
            .setBodyParameters(user)
            .build()
    }
    
    private func makeRankingAPI() -> URLRequest? {
        return URLRequestBuilder(baseURL: API.baseURL)
            .setMethod(.get)
            .setPath("/ranking")
            .build()
    }
    
    private func makeMyRankingAPI(userId: UserIdRequestDTO) -> URLRequest? {
        return URLRequestBuilder(baseURL: API.baseURL)
            .setMethod(.get)
            .setPath("/ranking/\(userId.userId)")
            .build()
    }
}

extension API {
    private static let baseURL = "wooseokjang.shop"
    private static let contentTypeKey = "Content-Type"
    private static let contentType = "application/json"
    private static let header = [
        API.contentTypeKey: API.contentType
    ]
}
