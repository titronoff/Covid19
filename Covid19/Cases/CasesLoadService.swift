//
//  LoadCasesData.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 11/12/20.
//

import UIKit

extension CasesTVC {
    
    @objc func getCases() {

        guard let url = URL(string: "https://api.apify.com/v2/key-value-stores/tVaYRsPHLjNdNBu7S/records/LATEST?disableRedirect=true") else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
            }
            if let data = data {
                do {
                    let newCases = try JSONDecoder().decode([Case].self, from: data)
                    cases = newCases
                    print(cases[0].country)
                    DispatchQueue.main.async {
                        self.refreshControl?.endRefreshing()
                        self.tableView.reloadData()
                    }
                } catch let jsonError {
                    print(jsonError)
                }
            }
        }.resume()

    }
}
