//
//  APIEngine.swift
//  CountryFacts
//
//  Created by Trupti sahoo on 23/12/19.
//  Copyright © 2019 Accenture. All rights reserved.
//

import Foundation

final class APIEngine {
  
  private var dataTask: URLSessionDataTask?
  private var session: URLSession
  
  init(session: URLSession = URLSession(configuration: .default)) {
    self.session = session
  }
  
  func enQueueRequest(url: String, onCompletion: @escaping (Result<CountryInfo>) -> Void) {
    guard let url = URL(string: url) else { return }
    
    dataTask?.cancel()
    let request = URLRequest(url: url)
    
    dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
      defer { self.dataTask = nil }
      
      //No Internet Connectivity
      guard let httpResponse = response as? HTTPURLResponse  else {
        onCompletion(Result.failure(NetworkError.network.reason))
        return
      }
      
      //Not receiving proper status code
      guard
        httpResponse.hasSuccessStatusCode,
        let data = data
        else {
          onCompletion(Result.failure(NetworkError.fetching.reason))
          return
      }
      
      // Decoding
      guard
        let decodedResponse = try? JSONDecoder().decode(CountryInfo.self, from: data) else {
          onCompletion(Result.failure(NetworkError.decoding.reason))
          return
      }
      onCompletion(Result.success(decodedResponse))
    })
    dataTask?.resume()
  }
}

//MARK:- APIs
extension APIEngine {
  
  func fetchCountryInfo(url: String, onCompletion: @escaping (Result<CountryInfo>) -> Void) {
    enQueueRequest(url: url) { (result) in
      onCompletion(result)
    }
  }
  
}
