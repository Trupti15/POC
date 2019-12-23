//
//  Route.swift
//  CountryFacts
//
//  Created by Trupti sahoo on 23/12/19.
//  Copyright © 2019 Accenture. All rights reserved.
//

import Foundation

enum Url {
    static let feedUrl = "https://api.myjson.com/bins/iij5n"
}

//MARK:- Response status code
extension HTTPURLResponse {
    var hasSuccessStatusCode: Bool {
        return 200...299 ~= statusCode
    }
}


//MARK:- NetworkError Message
enum NetworkError: Error {
    case network
    case fetching
    case decoding
    
    var reason: String {
        switch self {
        case .network:
            return "No Internet connection, \n Please check connectivity"
        case .fetching:
            return "An error occurred while fetching data \n Pull to refresh"
        case .decoding:
            return "An error occurred while decoding data \n Please try again"
        }
    }
}

//MARK:- Response: Success or Failure
enum Result<T> {
    case success(T)
    case failure(String)
}
