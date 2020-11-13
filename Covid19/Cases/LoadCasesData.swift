//
//  LoadCasesData.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 11/12/20.
//

import UIKit

var cases = [Case]()

func loadCases() {
    let session = URLSession(configuration: .default)
    guard let url = URL(string: "https://api.apify.com/v2/key-value-stores/tVaYRsPHLjNdNBu7S/records/LATEST?disableRedirect=true") else {return}
    let urlRequest = URLRequest(url: url)
    let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
        if let error = error {
            print(error)
        }
        if let data = data {
            do {
                cases = try JSONDecoder().decode([Case].self, from: data)
                print(cases)
            } catch  {
                print(error)
            }
        }
    }
    dataTask.resume()
    
}
