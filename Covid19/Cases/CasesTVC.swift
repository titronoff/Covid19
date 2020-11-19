//
//  CasesTableViewController.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 11/1/20.
//

import UIKit

class CasesTVC: UITableViewController {
    
    static func zeroChanger (_ input: Int) -> String {
        if input == 0 {
            return "N/A"
        } else {
            return String(input)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        configureTVRefreshControl()
        getCases()
    }

    //MARK: Generate test data


    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "CasesCell", for: indexPath) as! CasesCell
        cell.countryLb.text = cases[indexPath.row].country
        cell.infectedLb.text = CasesTVC.zeroChanger(cases[indexPath.row].infected ?? 0)
        cell.recoveredLb.text = CasesTVC.zeroChanger(cases[indexPath.row].recovered ?? 0)
        cell.deathLb.text = CasesTVC.zeroChanger(cases[indexPath.row].deceased ?? 0)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let caseDetailsVC = UIStoryboard(name: "CaseDetails", bundle: nil).instantiateViewController(withIdentifier: "CasesDetails") as! CaseDetailsVC
        caseDetailsVC.caseToShow = cases[indexPath.row]
        navigationController?.pushViewController(caseDetailsVC, animated: true)
        
    }
    
}
