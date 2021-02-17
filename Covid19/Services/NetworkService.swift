//
//  GetNetworkData.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 20.01.21.
//

import Foundation

protocol VideosRepository {
    func getVideos (videos: Videos, videosGroupeId: Int, completion: @escaping () -> ())
}
protocol NewsRepository {
    func getNews (news: News, newsGroupeId: Int, completion: @escaping () -> ())
}
protocol CasesRepository {
    func getCases (cases: Cases, completion: @escaping () -> ())
}

class NetworkService: VideosRepository, NewsRepository, CasesRepository {
    
    private let session = URLSession.shared
    
    func getVideos(videos: Videos, videosGroupeId: Int, completion: @escaping () -> ()) {
        guard let url = URL(string: videos.groups[videosGroupeId].url) else {print(#function, " URL error"); return}
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let data = data else {print(#function," URLSession error"); return}
            let videosList = try? JSONDecoder().decode(VideosList.self, from: data)
            if let videosList = videosList {
                videos.groups[videosGroupeId].list = videosList
                completion()
            } else {print(#function, " JSONDecoder error"); return}
        }
        task.resume()
    }

    func getNews(news: News, newsGroupeId: Int, completion: @escaping () -> ()) {
        guard let url = URL(string: news.groups[newsGroupeId].url) else {print(#function," URL error"); return}
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let data = data else {print(#function," URLSession error"); return}
            let newsFeed = try? JSONDecoder().decode(NewsFeed.self, from: data)
            if let newsFeed = newsFeed {
                news.groups[newsGroupeId].newsFeed = newsFeed
                completion()
            } else {print(#function," JSONDecoder error"); return}
        }
        task.resume()
    }
    
    func getCases(cases: Cases, completion: @escaping () -> ()) {
        guard let url = URL(string: cases.url) else {print(#function," URL error"); return}
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let data = data else {print(#function," URLSession error"); return}
            let casesList = try? JSONDecoder().decode([Case].self, from: data)
            if let casesList = casesList {
                cases.list = casesList
                completion()
            } else {print(#function," JSONDecoder error"); return}
        }
        task.resume()
    }
}
