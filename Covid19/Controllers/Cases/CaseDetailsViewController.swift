//
//  CountryCasesViewController.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 11/1/20.
//

import UIKit

class CaseDetailsViewController: UIViewController {
    
    // Dependecies
    private let textProcessor = Dependencies.container.resolve(TextProcessor.self)!
    
    //Outlest
    @IBOutlet weak var countryLb: UILabel!
    @IBOutlet weak var infectedLb: UILabel!
    @IBOutlet weak var recoveredLb: UILabel!
    @IBOutlet weak var deathLb: UILabel!
    @IBOutlet weak var updatedLb: UILabel!
    
    var caseToShow = Case("")
 
        
    override func viewDidLoad() {
        super.viewDidLoad()
        countryLb.text = caseToShow.country
        infectedLb.text = " " + textProcessor.zeroChanger(caseToShow.infected ?? 0) + " "
        recoveredLb.text = " " + textProcessor.zeroChanger(caseToShow.recovered ?? 0) + " "
        deathLb.text = " " + textProcessor.zeroChanger(caseToShow.deceased ?? 0) + " "
        if let updateDate = caseToShow.updated {
            updatedLb.text = "\(updateDate.dropLast(14))"
        } else {
            updatedLb.text = "N/A"
        }
    }
    
    @IBAction func swipeRight(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
