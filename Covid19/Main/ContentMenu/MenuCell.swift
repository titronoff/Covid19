//
//  NewsMenuCell.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 11/19/20.
//

import UIKit

class MenuCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLb: UILabel!
    @IBOutlet weak var underline: UIImageView!
    @IBOutlet weak var underlineHeight: NSLayoutConstraint!
    
    class func MenuHeight() -> CGFloat {
        return 50
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


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        underlineHeight.constant = 5
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
}
