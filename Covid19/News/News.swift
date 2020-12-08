//
//  Menu.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 11/19/20.
//

import Foundation

class News {
    var items = [NewsItem]()
    init() {
        setup()
    }
    func setup() {
        let apiKey = newsApiKey[0]
        self.items.append(NewsItem(name: "All Top", url: "https://newsapi.org/v2/top-headlines?q=covid&apiKey=\(apiKey)"))
        self.items.append(NewsItem(name: "BBC", url: "https://newsapi.org/v2/everything?q=covid&sources=bbc-news&apiKey=\(apiKey)"))
        self.items.append(NewsItem(name: "CBS", url: "https://newsapi.org/v2/everything?q=covid&sources=cbs-news&apiKey=\(apiKey)"))
        self.items.append(NewsItem(name: "CNN", url: "https://newsapi.org/v2/everything?q=covid&sources=cnn&apiKey=\(apiKey)"))
        self.items.append(NewsItem(name: "MSNBC", url: "https://newsapi.org/v2/everything?q=covid&sources=msnbc&apiKey=\(apiKey)"))
        self.items.append(NewsItem(name: "Business insider", url: "https://newsapi.org/v2/everything?q=covid&sources=business-insider&apiKey=\(apiKey)"))
    }
}
struct NewsItem {
    var name: String
    var url: String
    var articles = [Article]()
}
struct NewsFeed: Codable {
    var status: String = ""
    var totalResults: Int = 0
    var articles: [Article]?
    
}
struct Article: Codable {
    var source: Source
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
}
struct Source: Codable {
    var id: String?
    var name: String?
}
