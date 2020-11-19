//
//  Article.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 11/13/20.
//

import UIKit

struct Article: Codable {
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
}
