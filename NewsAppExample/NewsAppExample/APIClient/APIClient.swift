//
//  APIClient.swift
//  NewsAppExample
//
//  Created by DhakaLive on 12/3/20.
//  Copyright © 2020 DhakaLive. All rights reserved.
//

import Foundation

class APIClient {
    
    //private let baseURL = URL(string: "https://newsapi.org/")
    
    private let newsURL = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=abd2d17b58d94ccdb9302cbcf79dba8d")
    
    func getAllNews(_ completion: @escaping (Result<News, Error>) -> Void) {
        //let request = URLRequest(url: newsURL!)
        let task = URLSession.shared.dataTask(with: newsURL!) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            guard let result = data else {
                return
            }
            do {
                let news = try JSONDecoder().decode(News.self, from: result)
                completion(.success(news))
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
