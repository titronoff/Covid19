//
//  CasesTableViewController.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 11/1/20.
//

import UIKit

class CasesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCases()
        loadCases()
        tableView.tableFooterView = UIView()
    }

    //MARK: Generate test data


    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return allCountries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let countryName = allCountries[indexPath.row].country
        let confirmed = allCountries[indexPath.row].latest.confirmed
        let numDeths = allCountries[indexPath.row].latest.deaths
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CasesCell", for: indexPath) as! CasesTableViewCell
        
        cell.countryLabel.text = countryName
        cell.confirmedLabel.text = "Confirmed: \(confirmed)"
        cell.deathLabel.text = "Death: \(numDeths)"
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // segue - showCountryCases
        if segue.identifier == "showCountryCases" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let detailVC = segue.destination as! CountryCasesViewController
                detailVC.confirmed = allCountries[indexPath.row].latest.confirmed
                detailVC.death = allCountries[indexPath.row].latest.deaths
                
            }
        }
    }
}
