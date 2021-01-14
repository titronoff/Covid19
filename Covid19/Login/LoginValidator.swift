//
//  LoginValidator.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 12.01.21.
//

import UIKit

class LoginValidator : UserFieldsValidator {
    
    func loginCheck(_ usernameText: String, _  passwordText: String) -> Bool {
        return usernameText != "" && validatePassword(passwordText)
    }
    
    private func validatePassword(_ passwordText: String) -> Bool {
        return (passwordText.count >= 8 && differentCaseExisting(passwordText))
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
