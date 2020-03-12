//
//  Article.swift
//  NewsAppExample
//
//  Created by DhakaLive on 12/3/20.
//  Copyright © 2020 DhakaLive. All rights reserved.
//

import Foundation

class Article: Codable {
    var source: Source
    var author: String?
    var title: String
    var description: String
    var url: String
    var urlToImage: String
    var publishedAt: String
    var content: String?
    
}
