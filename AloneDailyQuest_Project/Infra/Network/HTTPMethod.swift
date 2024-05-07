//
//  HTTPMethod.swift
//  AloneDailyQuest_Project
//
//  Created by Wooseok on 5/7/24.
//

import Foundation

enum HTTPMethod: String {
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}

enum URLScheme: String {
    case http
    case https
}
