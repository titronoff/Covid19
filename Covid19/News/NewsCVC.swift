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
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    var refreshControl: UIRefreshControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.isHidden = false
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        configureRefreshControl()
        refreshControl?.beginRefreshing()
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

    func configureRefreshControl () {
       // Add the refresh control to your UIScrollView object.
       self.refreshControl = UIRefreshControl()
       self.refreshControl?.addTarget(self, action:
                                          #selector(getNewsFeedData),
                                          for: .valueChanged)
    }
}
