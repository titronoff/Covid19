//
//  LoadCasesData.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 11/12/20.
//

import UIKit

extension CasesTVC {
    
    @objc func getCasesData() {
        
        self.refreshControl?.beginRefreshing()
        self.cases.removeAll()
        self.tableView.reloadData()
        
        guard let url = URL(string: casesSourceUrl) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
            }
            if let data = data {
                do {
                    let newCases = try JSONDecoder().decode([Case].self, from: data)
                    self.cases = newCases
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
    
    func configureTVRefreshControl () {
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action:
                                          #selector(getCasesData),
                                          for: .valueChanged)
    }
}
