//
//  NewsCollectionViewController.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 11/1/20.
//

import UIKit

private let reuseIdentifier = "NewsCell"

class NewsCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        getNews()
        super.viewDidLoad()

    }


    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return news.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! NewsViewCell
    
        let author = news[indexPath.row].author
        let title = news[indexPath.row].title
        
        cell.newsAuthorLabel.text = author
        cell.newsTitleLabel.text = title
    
        return cell
    }


}
