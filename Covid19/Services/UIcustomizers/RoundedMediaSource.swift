//
//  mediaName.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 24.11.20.
//

import UIKit

class RoundedMediaSource: UILabel {
    override func didMoveToWindow() {
        layer.cornerRadius = self.frame.height/3
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 0.5
        layer.backgroundColor = UIColor.systemBlue.cgColor
    }

}
