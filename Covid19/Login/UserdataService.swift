//
//  LoginManager.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 11/13/20.
//

import Foundation
import KeychainAccess

extension LoginVC {
    
    func getLoginData() {
        let keychain = Keychain(service: "com.ivanovski.covid19-token")
        //if let lastLoginData = UserDefaults.standard.data(forKey: "userData") {
        if let lastLoginData = keychain[data: "userdata"] {
            let decoder = PropertyListDecoder()
            let restoredUser = try? decoder.decode(Userdata.self, from: lastLoginData)
            self.usernameInputField.text = restoredUser?.username ?? ""
        }
    }
    
    func saveLoginData() {
        let keychain = Keychain(service: "com.ivanovski.covid19-token")
        userdata.username = usernameInputField.text ?? ""
        userdata.password = passwordInputField.text ?? ""
        
        if userdata.username != "" {
            let encoder = PropertyListEncoder()
            let data = try? encoder.encode(userdata)
            //UserDefaults.standard.setValue(data, forKey: "userData")

            keychain[data: "userdata"] = data
        }
            


    }
}
