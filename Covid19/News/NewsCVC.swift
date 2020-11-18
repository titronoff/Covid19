//
//  NewsCollectionViewController.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 11/1/20.
//

import UIKit
import SafariServices

private let reuseIdentifier = "NewsCell"

// var newsFeed: NewsFeed

class NewsCVC: UICollectionViewController {
    
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //collectionView.layoutIfNeeded()
        getNewsFeedData()
       
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
            DispatchQueue.global(qos: .background).async {
                let img = Downloader.downloadImageWithURL(url: imgUrl)
                DispatchQueue.main.async {
                    cell.imageLb.image = img
                }
            }
        }
        return cell
    }
    
    // MARK: Safari controller
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let url = articles[indexPath.row].url else {return}
        let sfVC = SFSafariViewController(url: URL(string: url)!)
        present(sfVC, animated: true, completion: nil)
    }
}
