//
//  LoginValidator.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 12.01.21.
//

import UIKit

protocol UserFieldsValidator {
    func loginFieldsCheck(_ usernameText: String, _  passwordText: String) -> Bool
}

class UserFieldsChecker : UserFieldsValidator {
    
    func loginFieldsCheck(_ usernameText: String, _  passwordText: String) -> Bool {
        return validateUsername(usernameText) && validatePassword(passwordText)
    }
    
    private func validateUsername(_ usernameText: String) -> Bool {
        let text = usernameText.trimmingCharacters(in: .whitespacesAndNewlines)
        if text.count >= 5 {
            if isValidEmail(text) {
                return true
            }
        }
        return false
    }
    
    private func validatePassword(_ passwordText: String) -> Bool {
        return (passwordText.count >= 8 && differentCaseExisting(passwordText))
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let __firstpart = "[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?"
        let __serverpart = "([A-Z0-9a-z]([A-Z0-9a-z-]{0,30}[A-Z0-9a-z])?\\.){1,5}"
        let __emailRegex = __firstpart + "@" + __serverpart + "[A-Za-z]{2,8}"
        let __emailPredicate = NSPredicate(format: "SELF MATCHES %@", __emailRegex)
        
        return __emailPredicate.evaluate(with: email)
    }
    
    private func differentCaseExisting(_ str: String) -> Bool {
        var upperCase = false
        var lowerCase = false
        for char in str {
            if char.isUppercase {
                 upperCase = true
             }
            if char.isLowercase {
                lowerCase = true
            }
         }
        return (upperCase && lowerCase)

     }
}
