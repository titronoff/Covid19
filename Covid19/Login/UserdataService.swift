//
//  LoginManager.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 11/13/20.
//

import Foundation

extension LoginVC {
    
    func loginCheck() {
        if usernameInputField.text! != "" && passwordInputField.text != "" {
        loginButton.isEnabled = true
        loginButton.backgroundColor = .systemGreen
        } else {
            loginButton.isEnabled = false
            loginButton.backgroundColor = .lightGray
        }
    }
    
    func getLoginData() {
        if let lastLoginData = UserDefaults.standard.data(forKey: "userData") {
            let decoder = PropertyListDecoder()
            let restoredUser = try? decoder.decode(Userdata.self, from: lastLoginData)
            usernameInputField.text = restoredUser?.username ?? ""
        }
    }
    
    func saveLoginData() {
        user.username = usernameInputField.text ?? ""
        if user.username != "" {
            let encoder = PropertyListEncoder()
            let data = try? encoder.encode(user)
            UserDefaults.standard.setValue(data, forKey: "userData")
        }
    }
}
