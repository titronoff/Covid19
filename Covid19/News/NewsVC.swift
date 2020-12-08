//
//  NewsVC.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 11/19/20.
//

import UIKit
import SafariServices

class NewsVC: UIViewController {

    @IBOutlet weak var menuCV: UICollectionView!
    @IBOutlet weak var contentCV: UICollectionView!
    @IBOutlet weak var menuHeight: NSLayoutConstraint!
    
    var news: News = News()
    var selectedMenuItem = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.contentCV.collectionViewLayout.self
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
        if selectedMenuItem >= 0 && selectedMenuItem < news.items.count-1 {
            selectedMenuItem += 1
            menuCV.reloadData()
            getNewsData()
            print(#function)

        }
        print(news.items.count," ",selectedMenuItem)
    }
    @IBAction func guestRight(_ sender: UISwipeGestureRecognizer) {
        
        if (selectedMenuItem > 0 && selectedMenuItem < news.items.count) {
            selectedMenuItem -= 1
            menuCV.reloadData()
            getNewsData()
            print(#function)
        }
        print(news.items.count," ",selectedMenuItem)
    }
}
//MARK: Cells operations
extension NewsVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == menuCV {
            return news.items.count
        } else {
            return news.items[selectedMenuItem].articles.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == menuCV {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: indexPath) as! MenuCell
            let item = news.items[indexPath.row]
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
            let item = news.items[selectedMenuItem].articles[indexPath.row]
            cell.setupArticle(item: item, group: selectedMenuItem)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == contentCV {
            return calculateArticleCellsize()
        } else {
            var menuTitles = [String]()
            for title in news.items {
                menuTitles.append(title.name)
            }
            return MenuCell.calculateMenuItemCellsize(menuTitles, indexPath.row)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == menuCV {
            selectedMenuItem = indexPath.row
            contentCV.refreshControl?.beginRefreshing()
            getNewsData()
            menuCV.reloadData()
            //contentCV.reloadData()
        } else {
            Browser.OpenUrl(news.items[selectedMenuItem].articles[indexPath.row].url, self)
        }
    }
//MARK: Calculations for cells sizing
    
    func calculateArticleCellsize() -> CGSize {
        let mWidth = UIScreen.main.bounds.width
        return CGSize(width: (mWidth/2 - 0.5), height: (mWidth/2))
    }
}

