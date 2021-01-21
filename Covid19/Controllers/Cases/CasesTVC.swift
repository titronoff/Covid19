//
//  CasesTableViewController.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 11/1/20.
//

import UIKit

class CasesTVC: UITableViewController {
    
    var cases = [Case]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "CaseCell", bundle: nil), forCellReuseIdentifier: "CaseCell")
        tableView.tableFooterView = UIView()
        configureTVRefreshControl()
        getCasesData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CaseCell", for: indexPath) as! CaseCell
        cell.setupCell(cases[indexPath.row])
       return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let caseDetailsVC = UIStoryboard(name: "CaseDetails", bundle: nil).instantiateViewController(withIdentifier: "CasesDetails") as! CaseDetailsVC
        caseDetailsVC.caseToShow = cases[indexPath.row]
        navigationController?.pushViewController(caseDetailsVC, animated: true)
        
    }
    
}
