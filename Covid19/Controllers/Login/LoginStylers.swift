//
//  Styler.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 19.01.21.
//

import UIKit
import Swinject


class LoginStylerLight: UIstyle {
    func backgroundColor() -> UIColor {
        return UIColor.white
    }
    
    func fontColor() -> UIColor {
        return UIColor.black
    }
 
}

class LoginStylerDark: UIstyle {
    func backgroundColor() -> UIColor {
        return UIColor.black
    }
    
    func fontColor() -> UIColor {
        return UIColor.orange
    }

}

class StyleProvider {
    let date = Date()
    let calendar = Calendar.current
    
    func getBgColor () -> UIColor {
        if timeCheck() {
            let color = Dependencies.container.resolve(UIstyle.self, name: "Light")?.backgroundColor()
            return color!
        } else {
            let color = Dependencies.container.resolve(UIstyle.self, name: "Dark")?.backgroundColor()
            return color!
        }
    }
    
    func getTextColor() -> UIColor  {
        if timeCheck() {
            let color = Dependencies.container.resolve(UIstyle.self, name: "Light")?.fontColor()
            return color!
        } else {
            let color = Dependencies.container.resolve(UIstyle.self, name: "Dark")?.fontColor()
            return color!
        }
    }
    
    private func timeCheck () -> Bool {
        let hour  = calendar.component(.hour, from: date)
        if hour <= 19 && hour >= 8 {
            return true
        } else {
            return false
        }
    }
}
