//
//  NewsVC.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 11/19/20.
//

import UIKit
import SafariServices

class NewsVC: UIViewController {
    
    // Dependecies
    private let network = Dependencies.container.resolve(NewsRepository.self)!
    private let browser = Dependencies.container.resolve(Browser.self)!

    //Outlets
    @IBOutlet weak var menuCV: UICollectionView!
    @IBOutlet weak var contentCV: UICollectionView!
    @IBOutlet weak var menuHeight: NSLayoutConstraint!
    private let refresher = UIRefreshControl()
    
    //Data
    private var news: News = News()
    private var selectedMenuItem = 0
    
    override internal func viewDidLoad() {
        super.viewDidLoad()
 
        menuHeight.constant = MenuCell.MenuHeight()
        self.menuCV.register(UINib(nibName: "MenuCell", bundle: nil), forCellWithReuseIdentifier: "MenuCell")
        self.menuCV.dataSource = self
        self.menuCV.delegate = self
        
        self.contentCV.register(UINib(nibName: "ArticleCell", bundle: nil), forCellWithReuseIdentifier: "ArticleCell")
        self.contentCV.dataSource = self
        self.contentCV.delegate = self
        
        configureRefreshControler()
        getNewsData()
    }
//MARK: Gestures - Swipes right & left
    @IBAction func swipeLeft(_ sender: UISwipeGestureRecognizer) {
        if selectedMenuItem >= 0 && selectedMenuItem < news.groups.count-1 {
            selectedMenuItem += 1
            menuCV.reloadData()
            getNewsData()
            contentCV.reloadData()
        }
    }
    @IBAction func guestRight(_ sender: UISwipeGestureRecognizer) {
        
        if (selectedMenuItem > 0 && selectedMenuItem < news.groups.count) {
            selectedMenuItem -= 1
            menuCV.reloadData()
            getNewsData()
            contentCV.reloadData()
        }

    }
//MARK: Get Network data
    @objc private func getNewsData() {
        refresher.beginRefreshing()
        network.getNews(news: news, newsGroupeId: selectedMenuItem) {
            DispatchQueue.main.async {
                self.refresher.endRefreshing()
                self.contentCV.reloadData()
            }
        }
    }
    
//MARK: Calculations for cells sizing
        
    private func calculateArticleCellsize() -> CGSize {
        let mWidth = UIScreen.main.bounds.width
        return CGSize(width: (mWidth/2 - 0.5), height: (mWidth/2))
    }
        
//MARK: Configure Refresh Controler
    private func configureRefreshControler () {
        self.contentCV.addSubview(refresher)
        self.refresher.addTarget(self, action:
                                            #selector(getNewsData),
                                            for: .valueChanged)
    }
}
//MARK: Cells operations
extension NewsVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == menuCV {
            return news.groups.count
        } else {
            return news.groups[selectedMenuItem].newsFeed.articles.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == menuCV {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: indexPath) as! MenuCell
            let item = news.groups[indexPath.row]
            var selected = false
            if selectedMenuItem == indexPath.row {
                selected = true
            } else {
                selected = false
            }
            cell.setupCell(menuItem: item.name, selected: selected)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
            let item = news.groups[selectedMenuItem].newsFeed.articles[indexPath.row]
            cell.setupArticle(item: item, group: selectedMenuItem)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == contentCV {
            return calculateArticleCellsize()
        } else {
            var menuTitles = [String]()
            for title in news.groups {
                menuTitles.append(title.name)
            }
            return MenuCell.calculateMenuItemCellsize(menuTitles, indexPath.row)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == menuCV {
            selectedMenuItem = indexPath.row
            getNewsData()
            menuCV.reloadData()
            contentCV.reloadData()
        } else {
            browser.OpenUrl(news.groups[selectedMenuItem].newsFeed.articles[indexPath.row].url, self)
        }
    }

}

