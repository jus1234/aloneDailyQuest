//
//  MemberData.swift
//  AloneDailyQuest_Project
//
//  Created by Matthew on 12/9/23.
//

import Foundation

//enum NetworkError: LocalizedError {
//    case invalidURLError
//    case noDataError
//    case requestFailError
//    case invalidResponseError
//    case redirectionError
//    case clientError
//    case serverError
//    case decodingError
//    
//    var errorDescription: String? {
//        switch self {
//        case .invalidURLError:
//            return "잘못된 URL 주소입니다."
//        case .noDataError:
//            return "데이터가 존재하지 않습니다."
//        case .requestFailError:
//            return "요청에 실패 했습니다."
//        case .invalidResponseError:
//            return "잘못된 요청 입니다."
//        case .redirectionError:
//            return "리다이렉션 에러 발생"
//        case .clientError:
//            return "사용자 요청 에러 발생"
//        case .serverError:
//            return "서버 에러 발생"
//        case .decodingError:
//            return "JSON 디코딩 에러 발생"
//        }
//    }
//}

class APIService {
    private let session: URLSession = URLSession.shared
    
    func fetchData(urlString: String, completion: @escaping (Result<UserInfo, NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else {
//            completion(.failure(.invalidURLError))
            return
        }
        self.sessionDataTask(url: url, completion: completion)
    }
    
    func sessionDataTask(url: URL, completion: @escaping (Result<UserInfo, NetworkError>) -> Void) {
        self.session.dataTask(with: url) { data, response, error in
            DispatchQueue.global().async {
                guard error == nil else {
//                    completion(.failure(.requestFailError))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
//                    completion(.failure(.invalidResponseError))
                    return
                }
                
                guard let data = data else {
//                    completion(.failure(.noDataError))
                    return
                }
                
                self.checkStatusCode(data: data, statusCode: httpResponse, completion: completion)
            }
        }.resume()
    }
    
    func checkStatusCode(data: Data, statusCode: HTTPURLResponse, completion: @escaping (Result<UserInfo, NetworkError>) -> Void) {
        switch statusCode.statusCode {
        case 300..<400:
//            completion(.failure(.redirectionError))
            return
        case 400..<500:
//            completion(.failure(.clientError))
            return
        case 500..<600:
//            completion(.failure(.serverError))
            return
        default:
            self.resultDecodedData(data: data, completion: completion)
        }
    }
    
    func resultDecodedData(data: Data, completion: @escaping (Result<UserInfo, NetworkError>) -> Void){
        do {
            let decodedData = try JSONDecoder().decode(UserInfo.self, from: data)
            completion(.success(decodedData))
        } catch {
//            completion(.failure(.decodingError))
        }
    }
    func repuestSignupData(userNickName: String, completion: @escaping (Result<UserInfo, NetworkError>) -> Void) {
        guard let url = URL(string: "http://wooseokjang.shop/signup") else {
//            completion(.failure(.invalidURLError))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let postData = try? JSONSerialization.data(withJSONObject: ["userId": userNickName])
        request.httpBody = postData
        
        self.sessionDataTask(url: url, completion: completion)
    }
    
    func repuestCheckIdData(userNickName: String, completion: @escaping (Result<UserInfo, NetworkError>) -> Void) {
        
        let jsonData = ["userId": userNickName]
        
        guard let url = URL(string: "http://wooseokjang.shop/check_id") else {
//            completion(.failure(.invalidURLError))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: jsonData)
        
        self.sessionDataTask(url: url, completion: completion)
    }
    
    func repuestLoginData(userNickName: String, urlString: String, completion: @escaping (Result<UserInfo, NetworkError>) -> Void) {
        let jsonData = ["userId": userNickName]
        
        guard let url = URL(string: "http://wooseokjang.shop/login") else {
//            completion(.failure(.invalidURLError))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: jsonData)
        
        self.sessionDataTask(url: url, completion: completion)
    }
    
    func requestAddExperience(userNickName: String, userExperience: String, completion: @escaping (Result<UserInfo, NetworkError>) -> Void) {
        let jsonData = ["userId" : userNickName,
                    "experience" : userExperience]
        
        guard let url = URL(string: "http://wooseokjang.shop/add_experience") else {
//            completion(.failure(.invalidURLError))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: jsonData)
        
        self.sessionDataTask(url: url, completion: completion)
    }
}
