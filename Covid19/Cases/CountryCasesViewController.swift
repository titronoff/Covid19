//
//  CountryCasesViewController.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 11/1/20.
//

import UIKit

class CountryCasesViewController: UIViewController {

    @IBOutlet weak var confirmedLabel: UILabel!
    @IBOutlet weak var deathsLabel: UILabel!
    
    var confirmed = 0
    var death = 0
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        confirmedLabel.text = "Confirmed: \(confirmed)"
        deathsLabel.text = "Death: \(death)"
    }
}
