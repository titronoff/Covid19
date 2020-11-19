//
//  newsData.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 11/3/20.
//

import Foundation

struct NewsFeed: Codable {
    var status: String = ""
    var totalResults: Int = 0
    var articles: [Article]?
    
}

