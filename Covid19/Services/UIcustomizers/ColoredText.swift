//
//  coloredText.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 24.11.20.
//

import UIKit

class ColoredTextRed: UILabel {
    override func didMoveToWindow() {
        layer.backgroundColor = UIColor.systemRed.cgColor
        textColor = UIColor.white
        layer.cornerRadius = font.pointSize / 3
        
    }
}
class ColoredTextBlue: UILabel {
    override func didMoveToWindow() {
        layer.backgroundColor = UIColor.systemBlue.cgColor
        textColor = UIColor.white
        layer.cornerRadius = font.pointSize / 3
        
    }
}
class ColoredTextBlack: UILabel {
    override func didMoveToWindow() {
        layer.backgroundColor = UIColor.black.cgColor
        textColor = UIColor.white
        layer.cornerRadius = font.pointSize / 3
        
    }
}
