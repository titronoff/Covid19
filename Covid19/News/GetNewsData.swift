//
//  LoadNewsService.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 11/20/20.
//

import UIKit

extension NewsVC {
    
    @objc func getNewsData() {
        
        self.contentCV.refreshControl?.beginRefreshing()
        self.news.items[self.selectedMenuItem].articles.removeAll()
        self.contentCV.reloadData()
        
        let urlString = news.items[selectedMenuItem].url
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                //handle error
                print("news data response error: ",error)
            }
            guard let data = data else {return}
            do {
                let newsFeed = try JSONDecoder().decode(NewsFeed.self, from: data)
                guard let newArticles = newsFeed.articles else {return}
                DispatchQueue.main.async {
                    self.news.items[self.selectedMenuItem].articles = newArticles
                    self.contentCV.refreshControl?.endRefreshing()
                    self.contentCV.reloadData()
                }
            } catch let jsonError {
                print("news json parsing error:", jsonError)
            }
        }.resume()
    }
    
    
    
    func configureRefreshControler () {
        self.contentCV.refreshControl = UIRefreshControl()
        self.contentCV.addSubview(contentCV.refreshControl!)
        self.contentCV.refreshControl?.addTarget(self, action:
                                          #selector(getNewsData),
                                          for: .valueChanged)
    }
}
