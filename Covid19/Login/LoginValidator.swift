//
//  LoginValidator.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 12.01.21.
//

import UIKit

class LoginValidator {
    
    static func loginCheck(_ usernameText: String, _  passwordText: String) -> Bool {
        if usernameText != "" && validatePassword(passwordText) {
            return true
        } else {
            return false
        }
    }
    
    private static func validatePassword(_ passwordText: String) -> Bool {
        if passwordText.count >= 8 && differentCaseExisting(passwordText) {
            return true
        } else {
            return false
        }
    }
    
    private static func differentCaseExisting(_ str: String) -> Bool {
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
        if upperCase && lowerCase {
            return true
        } else {
            return false
        }
     }
}
