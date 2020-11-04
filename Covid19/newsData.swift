//
//  newsData.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 11/3/20.
//

import Foundation

var news = [Article]()

struct Article {
    let author: String
    let title: String
}
func getNews() {
    news.append(Article(author: "Author1", title: "News 1"))
    news.append(Article(author: "Author2", title: "News 2"))
    news.append(Article(author: "Author3", title: "News 3"))
    news.append(Article(author: "Author4", title: "News 4"))
}
