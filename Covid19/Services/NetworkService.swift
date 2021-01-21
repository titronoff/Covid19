//
//  GetNetworkData.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 20.01.21.
//

import Foundation



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
