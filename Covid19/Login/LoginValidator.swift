//
//  LoginValidator.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 12.01.21.
//

import UIKit

class LoginValidator {
    
    static func loginCheck(_ usernameText: String, _  passwordText: String) -> Bool {
        if usernameText != "" && passwordText != "" {
            return true
        } else {
            return false
        }
    }
}
