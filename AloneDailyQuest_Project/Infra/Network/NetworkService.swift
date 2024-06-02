//
//  NetworkService.swift
//  AloneDailyQuest_Project
//
//  Created by Wooseok on 5/7/24.
//

import Foundation
import RxSwift

enum NetworkError: Error {
    case error(statusCode: Int, data: Data?)
    case notConnected
    case cancelled
    case generic(Error)
    case dataError
    case urlRequestBuildError
}

protocol NetworkService {
    typealias Observable = RxSwift.Observable
    
    func request(_ api: API) async throws -> Data
    func requestObservable(_ api: API) -> Observable<Data>
}

extension NetworkService {
    func configureNetworkError(_ error: Error) -> NetworkError {
        let code = URLError.Code(rawValue: (error as NSError).code)
        switch code {
        case .notConnectedToInternet:
            return .notConnected
        case .cancelled:
            return .cancelled
        default:
            return .generic(error)
        }
    }
}

final class DefaultNetworkService: NetworkService {
    typealias Observable = RxSwift.Observable
    
    func request(_ api: API) async throws -> Data {
        guard let urlRequest = api.toURLRequest() else {
            throw NetworkError.urlRequestBuildError
        }
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            if let httpResponse = response as? HTTPURLResponse,
                !(200..<300 ~= httpResponse.statusCode) {
                throw NetworkError.error(statusCode: httpResponse.statusCode, data: data)
            }
            return data
        } catch {
            throw configureNetworkError(error)
        }
    }
    
    func requestObservable(_ api: API) -> Observable<Data> {
        return Observable.create { observer in
            Task {
                do {
                    try await observer.onNext(self.request(api))
                } catch {
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
