//
//  CasesTableViewController.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 11/1/20.
//

import UIKit

class CasesTVC: UITableViewController {
    
    // Dependecies
    private let network = Dependencies.container.resolve(CasesRepository.self)!

    //Data
    private var cases = Cases()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "CaseCell", bundle: nil), forCellReuseIdentifier: "CaseCell")
        tableView.tableFooterView = UIView()
        configureRefreshControler()
        getCasesData()
    }

//MARK: Get Network data
        @objc private func getCasesData() {
            refreshControl?.beginRefreshing()
            network.getCases(cases: cases){
                DispatchQueue.main.async {
                    self.refreshControl?.endRefreshing()
                    self.tableView.reloadData()
                }
            }
        }

//MARK: Configure Refresh Controler
        private func configureRefreshControler () {
            self.refreshControl = UIRefreshControl()
            self.refreshControl?.addTarget(self, action:
                                                #selector(getCasesData),
                                                for: .valueChanged)
        }

// MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cases.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CaseCell", for: indexPath) as! CaseCell
        cell.setupCell(cases.list[indexPath.row])
       return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let caseDetailsVC = UIStoryboard(name: "CaseDetails", bundle: nil).instantiateViewController(withIdentifier: "CasesDetails") as! CaseDetailsVC
        caseDetailsVC.caseToShow = cases.list[indexPath.row]
        navigationController?.pushViewController(caseDetailsVC, animated: true)
        
    }
    
}
