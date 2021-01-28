//
//  LoginManager.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 11/13/20.
//

import Foundation
import KeychainAccess

protocol KeychainUserdata {
    func getLoginData() -> String
    func saveLoginData(username: String)
}

class KeychainUserdataService: KeychainUserdata {
    func getLoginData() -> String {
        let keychain = Keychain(service: "com.ivanovski.covid19-token")
        if let lastLoginData = keychain[data: "userdata"] {
            let decoder = PropertyListDecoder()
            let restoredUser = try? decoder.decode(Userdata.self, from: lastLoginData)
            return restoredUser?.username ?? ""
        }
        return ""
    }
    
    func saveLoginData(username: String) {
        let keychain = Keychain(service: "com.ivanovski.covid19-token")
        userdata.username = username
        userdata.lastLoginDate = Date()
        
        if userdata.username != "" {
            let encoder = PropertyListEncoder()
            let data = try? encoder.encode(userdata)
            keychain[data: "userdata"] = data
        }
    }
}
