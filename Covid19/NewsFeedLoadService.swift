//
//  LoadNewsFeedService.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 11/13/20.
//

import UIKit

extension NewsCVC {
    
    @objc func getNewsFeedData() {
        configureCVRefreshControl ()
        collectionView.addSubview(refreshControl)
        refreshControl.beginRefreshing()
        
        let urlString = "https://newsapi.org/v2/top-headlines?q=covid&apiKey=084c67c2b33148828b786875cbed3fc2"
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                //handle error
                print(error)
            }
            guard let data = data else {return}
            do {
                let newsFeed = try JSONDecoder().decode(NewsFeed.self, from: data)
                guard let newArticles = newsFeed.articles else {return}
                DispatchQueue.main.async {
                    articles = newArticles
                    self.collectionView.reloadData()
                    self.refreshControl.endRefreshing()
                }
            } catch let jsonError {
                print(jsonError)
            }
        }.resume()
    }
    
    func configureCVRefreshControl () {
        self.refreshControl.addTarget(self, action:
                                          #selector(getNewsFeedData),
                                          for: .valueChanged)
    }
}
