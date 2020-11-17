//
//  NewsCollectionViewController.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 11/1/20.
//

import UIKit

private let reuseIdentifier = "NewsCell"

// var newsFeed: NewsFeed

class NewsCVC: UICollectionViewController {
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! NewsCell
        cell.authorLb.text = articles[indexPath.row].author ?? ""
        cell.titleLb.text = articles[indexPath.row].title ?? ""
        
        if let imgUrl = articles[indexPath.row].urlToImage {
            cell.imageLb.image = Downloader.downloadImageWithURL(url: imgUrl)
        }
        return cell
    }


}
