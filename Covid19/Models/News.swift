//
//  Menu.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 11/19/20.
//

import Foundation

class News {
    var groups = [NewsGroupe]()
    let newsApiKey = ["084c67c2b33148828b786875cbed3fc2", //main
                      "836119757a1d4881ad4d1050682f658a", //1
                      "105f39ee084f4a7593a5df52902cba2e", //2
                      "9b23a0a02ce441419d1e10fa2376ab1c", //3
                      "0421233d9abb47b1a05338cf4e403508", //4
                      "fdbaf3a7e09b483daad5015193c88b68"] //5
    init() {
        let apiKey = newsApiKey[0]
        self.groups.append(NewsGroupe(id: 0, name: "All Top", url: "https://newsapi.org/v2/top-headlines?q=covid&apiKey=\(apiKey)"))
        self.groups.append(NewsGroupe(id: 1, name: "BBC", url: "https://newsapi.org/v2/everything?q=covid&sources=bbc-news&apiKey=\(apiKey)"))
        self.groups.append(NewsGroupe(id: 2, name: "CBS", url: "https://newsapi.org/v2/everything?q=covid&sources=cbs-news&apiKey=\(apiKey)"))
        self.groups.append(NewsGroupe(id: 3, name: "CNN", url: "https://newsapi.org/v2/everything?q=covid&sources=cnn&apiKey=\(apiKey)"))
        self.groups.append(NewsGroupe(id: 4, name: "MSNBC", url: "https://newsapi.org/v2/everything?q=covid&sources=msnbc&apiKey=\(apiKey)"))
        self.groups.append(NewsGroupe(id: 5, name: "Business insider", url: "https://newsapi.org/v2/everything?q=covid&sources=business-insider&apiKey=\(apiKey)"))
    }
}
struct NewsGroupe {
    var id: Int
    var name: String
    var url: String
    var newsFeed = NewsFeed()
}
struct NewsFeed: Codable {
    var status: String = ""
    var totalResults: Int = 0
    var articles = [Article]()
    
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
