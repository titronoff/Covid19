//
//  CountryCasesViewController.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 11/1/20.
//

import UIKit

class CaseDetailsVC: UIViewController {

    @IBOutlet weak var countryLb: UILabel!
    @IBOutlet weak var infectedLb: UILabel!
    @IBOutlet weak var recoveredLb: UILabel!
    @IBOutlet weak var deathLb: UILabel!
    @IBOutlet weak var updatedLb: UILabel!
    
    var country = ""
    var infected = 0
    var recovered = 0
    var death = 0
    var updated = ""
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        countryLb.text = country
        infectedLb.text = CasesTVC.zeroChanger(infected)
        recoveredLb.text = CasesTVC.zeroChanger(recovered)
        deathLb.text = CasesTVC.zeroChanger(death)
        updatedLb.text = "Updated: \(updated.dropLast(14))"
    }
}
