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
        guard let url = URL(string: videos.groups[videosGroupeId].url) else {print("#function URL error"); return}
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let data = data else {print("#function URLSession error"); return}
            let videosList = try? JSONDecoder().decode(VideosList.self, from: data)
            if let videosList = videosList {
                videos.groups[videosGroupeId].list = videosList
                completion()
            } else {print("#function JSONDecoder error"); return}
        }
        task.resume()
    }

    func getNews(news: News, newsGroupeId: Int, completion: @escaping () -> ()) {
        guard let url = URL(string: news.groups[newsGroupeId].url) else {print("#function URL error"); return}
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let data = data else {print("#function URLSession error"); return}
            let newsFeed = try? JSONDecoder().decode(NewsFeed.self, from: data)
            if let newsFeed = newsFeed {
                news.groups[newsGroupeId].newsFeed = newsFeed
                completion()
            } else {print("#function JSONDecoder error"); return}
        }
        task.resume()
    }
    
    func getCases(cases: Cases, completion: @escaping () -> ()) {
        guard let url = URL(string: cases.url) else {print("#function URL error"); return}
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let data = data else {print("#function URLSession error"); return}
            let casesList = try? JSONDecoder().decode([Case].self, from: data)
            if let casesList = casesList {
                cases.list = casesList
                completion()
            } else {print("#function JSONDecoder error"); return}
        }
        task.resume()
    }
    
    
}


/*
class NetworkService {
    
    func dataRequester (urlString: String, completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: urlString) else {return}
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                DispatchQueue.main.async {
                // do something in main trhead after request completion
                    completion(data, error)
                    }
                }
            }
        task.resume()
     }
    
    func videosFetcher (urlString: String) {
        dataRequester(urlString: urlString) { (data, error) in
            let decoder = JSONDecoder()
            guard let data = data else {return}
            let responseData = try? decoder.decode(VideosList.self, from: data)
            print(responseData?.items.count)
        }
    }
    
    func newsFetcher (urlString: String) {
        dataRequester(urlString: urlString) { (data, error) in
            let decoder = JSONDecoder()
            guard let data = data else {return}
            let responseData = try? decoder.decode(NewsFeed.self, from: data)
            print(responseData?.articles?.count)
        }
    }
    
    func casesFetcher (urlString: String) {
        dataRequester(urlString: urlString) { (data, error) in
            let decoder = JSONDecoder()
            guard let data = data else {return}
            let responseData = try? decoder.decode([Case].self, from: data)
            print(responseData?.count)
        }
    }
}
*/
