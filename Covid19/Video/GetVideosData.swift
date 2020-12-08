//
//  LoadVideosService.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 11/21/20.
//

import UIKit

extension VideosVC {
    
     @objc func getVideosData() {
        self.videoListCV.refreshControl?.beginRefreshing()
        self.videos.groups[self.selectedMenuItem].list.items.removeAll()
        self.videoListCV.reloadData()
        
        let urlString = videos.groups[selectedMenuItem].url
        guard let url = URL(string: urlString) else {
            print("Videos URL error: ", urlString)
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                //handle error
                print("URLSession error: ", error)
            }
            guard let data = data else {return}
            do {
                print(data)
                let videosList = try JSONDecoder().decode(VideosList.self, from: data)
                DispatchQueue.main.async {
                    self.videos.groups[self.selectedMenuItem].list = videosList
                    self.videoListCV.refreshControl?.endRefreshing()
                    self.videoListCV.reloadData()
                }
            } catch let jsonError {
                print("Videos JSONDecoder error: ", jsonError)
            }
        }.resume()
    }

    func configureRefreshControler () {
        self.videoListCV.refreshControl = UIRefreshControl()
        self.videoListCV.addSubview(videoListCV.refreshControl!)
        self.videoListCV.refreshControl?.addTarget(self, action:
                                          #selector(getVideosData),
                                          for: .valueChanged)
    }
}
 
