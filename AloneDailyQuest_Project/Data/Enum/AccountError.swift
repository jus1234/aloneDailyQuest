//
//  AccountError.swift
//  AloneDailyQuest_Project
//
//  Created by Wooseok on 5/7/24.
//

import Foundation

enum SignupError: Error {
    case missingInformation
    case userIdAlreadyExists
    
    init(errorMessage: String) {
        switch errorMessage {
        case "Missing information":
            self = .missingInformation
        default:
            self = .userIdAlreadyExists
        }
    }
}

enum LoginError: Error {
    case invalidCredentials
    
    init?(errorMessage: String) {
        if errorMessage == "Invalid credentials" {
            self = .invalidCredentials
        } else {
            return nil
        }
        
    }
}

enum AccountError: Error {
    case userNotFound
    
    init?(errorMessage: String) {
        if errorMessage == "User not found" {
            self = .userNotFound
        } else {
            return nil
        }
    }
}
