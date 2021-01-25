//
//  Styler.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 19.01.21.
//

import UIKit
import Swinject

protocol UIstyle {
    
    func getBgColor() -> UIColor
    func getTextColor() -> UIColor

}

class StyleProvider: UIstyle {
    
    func getBgColor () -> UIColor {
        if timeCheck() {
            let color = UIColor.white
            return color
        } else {
            let color = UIColor.white
            return color
        }
    }
    
    func getTextColor() -> UIColor  {
        if timeCheck() {
            let color = UIColor.black
            return color
        } else {
            let color = UIColor.black
            return color
        }
    }
    
    private func timeCheck () -> Bool {
        let date = Date()
        let calendar = Calendar.current
        let hour  = calendar.component(.hour, from: date)
        if hour <= 19 && hour >= 8 {
            return true
        } else {
            return false
        }
    }
}
