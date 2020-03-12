//
//  News.swift
//  NewsAppExample
//
//  Created by DhakaLive on 12/3/20.
//  Copyright © 2020 DhakaLive. All rights reserved.
//

import Foundation

class News: Codable {
    var status: String
    var totalResults: Int
    var articles: [Article]
    
}
