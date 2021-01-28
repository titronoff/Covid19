//
//  VideosVC.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 11/21/20.
//

import UIKit

class VideosViewController: UIViewController {
    
    // Dependecies
    private let network = Dependencies.container.resolve(VideosRepository.self)!
    private let browser = Dependencies.container.resolve(Browser.self)!
    
    //Outlets
    @IBOutlet weak var videoListCV: UICollectionView!
    @IBOutlet weak var menuCV: UICollectionView!
    @IBOutlet weak var menuHeight: NSLayoutConstraint!
    private let refresher = UIRefreshControl()
    
    //Data
    var videos: Videos = Videos()
    var selectedMenuItem = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuHeight.constant = MenuCell.MenuHeight()
        self.menuCV.register(UINib(nibName: "MenuCell", bundle: nil), forCellWithReuseIdentifier: "MenuCell")
        self.menuCV.dataSource = self
        self.menuCV.delegate = self
        
        self.videoListCV.register(UINib(nibName: "VideoCell", bundle: nil), forCellWithReuseIdentifier: "VideoCell")
        self.videoListCV.dataSource = self
        self.videoListCV.delegate = self
        
        configureRefreshControler()
        getVideosData()
    }
    
//MARK: Get Network data
    @objc private func getVideosData() {
        refresher.beginRefreshing()
        network.getVideos(videos: videos, videosGroupeId: selectedMenuItem) {
            DispatchQueue.main.async {
                self.refresher.endRefreshing()
                self.videoListCV.reloadData()
            }
        }
    }
    
//MARK: Calculations for cells sizing
    func calculateVideoCellsize() -> CGSize {
        let mWidth = UIScreen.main.bounds.width
        return CGSize(width: mWidth, height: (mWidth * 0.5625))
    }
    //    func calculateMenuItemCellsize(_ item: String) -> CGSize {
    //        var totalWidth : CGFloat = 0
    //        let mWidth = UIScreen.main.bounds.width
    //        for menuItem in self.news.items {
    //            totalWidth += menuItem.name.size(withAttributes:[.font: UIFont.systemFont(ofSize:12.0)]).width
    //        }
    //        let spacer = (mWidth - totalWidth) / CGFloat(news.items.count)
    //        let itemSize = String(item).size(withAttributes:[.font: UIFont.systemFont(ofSize:12.0)])
    //        let width = (itemSize.width + spacer)
    //        return CGSize(width: width , height: menuHeightNSC.constant)
    //    }
    
//MARK: Configure Refresh Controler
    func configureRefreshControler () {
        self.videoListCV.addSubview(refresher)
        self.videoListCV.refreshControl?.addTarget(self, action:
                                          #selector(getVideosData),
                                          for: .valueChanged)
    }
}
//MARK: Cells operations
extension VideosViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == menuCV {
            return videos.groups.count
        } else {
            return videos.groups[selectedMenuItem].list.items.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == menuCV {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: indexPath) as! MenuCell
            var selected = false
            if selectedMenuItem == indexPath.row {
                selected = true
            } else {
                selected = false
            }
            cell.setupCell(menuItem: videos.groups[indexPath.row].name, selected: selected)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCell", for: indexPath) as! VideoCell
            cell.setupCell(item: videos.groups[selectedMenuItem].list.items[indexPath.row])
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == menuCV {
            selectedMenuItem = indexPath.row
            getVideosData()
            videoListCV.reloadData()
            menuCV.reloadData()
        } else {
        let url = "https://www.youtube.com/watch?v=\(videos.groups[selectedMenuItem].list.items[indexPath.row].id.videoId)"
            browser.OpenUrl(url, self)
       }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == menuCV {
            var menuTitles = [String]()
            for title in videos.groups {
                menuTitles.append(title.name)
            }
            return MenuCell.calculateMenuItemCellsize(menuTitles, indexPath.row)
        } else {
            return calculateVideoCellsize()
        }
    }
}
