//
//  APIClient.swift
//  NewsAppExample
//
//  Created by DhakaLive on 12/3/20.
//  Copyright © 2020 DhakaLive. All rights reserved.
//

import Foundation

enum CustomError: Error {
    case responseError(desp: String)
}

class APIClient {
    
    //private let baseURL = URL(string: "https://newsapi.org/")
    
    private let newsURL = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=abd2d17b58d94ccdb9302cbcf79dba8d")
    
    func getAllNews(_ completion: @escaping (Result<News, CustomError>) -> Void) {
        //let request = URLRequest(url: newsURL!)
        let task = URLSession.shared.dataTask(with: newsURL!) { (data, response, error) in
            if let err = error {
                completion(.failure(CustomError.responseError(desp: err.localizedDescription)))
            }
            guard let result = data else {
                completion(.failure(CustomError.responseError(desp: "No respinse from server")))
                return
            }
            do {
                let news = try JSONDecoder().decode(News.self, from: result)
                completion(.success(news))
            } catch {
                completion(.failure(CustomError.responseError(desp: error.localizedDescription)))
            }
        }
        task.resume()
    }
}
