//
//  CaseCell.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 11/20/20.
//

import UIKit

class CaseCell: UITableViewCell {

    @IBOutlet weak var countryLb: UILabel!
    @IBOutlet weak var infectedLb: UILabel!
    @IBOutlet weak var recoveredLb: UILabel!
    @IBOutlet weak var deathLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    func setupCell(_ item: Case){
        countryLb.text = item.country
        infectedLb.text = " " + Editor.zeroChanger(item.infected ?? 0) + " "
        recoveredLb.text = " " + Editor.zeroChanger(item.recovered ?? 0) + " "
        deathLb.text = " " + Editor.zeroChanger(item.deceased ?? 0) + " "
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
