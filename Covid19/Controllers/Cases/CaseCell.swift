//
//  CaseCell.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 11/20/20.
//

import UIKit

class CaseCell: UITableViewCell {
    
    // Dependecies
    private let textProcessor = Dependencies.container.resolve(TextProcessor.self)!
    
    // Outlets
    @IBOutlet private weak var countryLb: UILabel!
    @IBOutlet private weak var infectedLb: UILabel!
    @IBOutlet private weak var recoveredLb: UILabel!
    @IBOutlet private weak var deathLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    func setupCell(_ item: Case){
        countryLb.text = item.country
        infectedLb.text = " " + textProcessor.zeroChanger(item.infected ?? 0) + " "
        recoveredLb.text = " " + textProcessor.zeroChanger(item.recovered ?? 0) + " "
        deathLb.text = " " + textProcessor.zeroChanger(item.deceased ?? 0) + " "
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
