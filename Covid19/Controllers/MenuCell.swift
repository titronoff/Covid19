//
//  NewsMenuCell.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 11/19/20.
//

import UIKit

class MenuCell: UICollectionViewCell {
    
    //Outlets
    @IBOutlet private weak var nameLb: UILabel!
    @IBOutlet private weak var underline: UIImageView!
    @IBOutlet private weak var underlineHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        underlineHeight.constant = 5
    }
    
    class func calculateMenuItemCellsize(_ items: [String], _ index: Int) -> CGSize {
        let height = MenuHeight()
        var totalWidth : CGFloat = 0
        let mWidth = UIScreen.main.bounds.width
        for menuItem in  items {
            totalWidth += menuItem.size(withAttributes:[.font: UIFont.systemFont(ofSize:12.0)]).width
        }
        let spacer = (mWidth - totalWidth) / CGFloat(items.count)
        let itemSize = String(items[index]).size(withAttributes:[.font: UIFont.systemFont(ofSize:12.0)])
        let width = (itemSize.width + spacer)
        return CGSize(width: width , height: height)
    }
    
    func setupCell(menuItem: String, selected: Bool) {
        nameLb.text = menuItem
        if selected == true {
            underline.backgroundColor = .systemBlue
            nameLb.font = UIFont.boldSystemFont(ofSize: 13)
        } else {
            underline.backgroundColor = .none
            nameLb.font = UIFont.systemFont(ofSize: 12)
        }
    }
    
    class func MenuHeight() -> CGFloat {
        return 50
    }
}
