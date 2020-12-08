//
//  File.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 24.11.20.
//

import UIKit

class RoundedButton: UIButton {
    override func didMoveToWindow() {
        backgroundColor = .clear
        layer.cornerRadius = self.frame.height / 2
        layer.borderWidth = 2
        setTitleColor(UIColor.systemGray, for: .disabled)
        setTitleColor(UIColor.systemBlue, for: .normal)
    }
}
