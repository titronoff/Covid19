//
//  LoginValidator.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 12.01.21.
//

import UIKit

class LoginValidator {
    
    static func loginCheck(_ usernameInputField: UITextField, _  passwordInputField: UITextField, _ loginButton: RoundedButton) {
        if usernameInputField.text != "" && passwordInputField.text != "" {
            loginButton.isEnabled = true
            loginButton.layer.borderColor = UIColor.systemBlue.cgColor
        
        } else {
            loginButton.isEnabled = false
            loginButton.layer.borderColor = UIColor.systemGray.cgColor
        }
    }
}
