//
//  LoginViewModel.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 28.01.21.
//

import Foundation
import KeychainAccess
import Swinject

protocol LoginViewModel {
    var loginText: String {get set}
    var passwordText: String {get set}
    func buttonSwitcher() -> Bool
    func keychainGetData() -> String
    func keychainSaveData()
    func login(completion: @escaping (String?) ->())
}

class LoginViewModelImpl: LoginViewModel {

    var loginText: String = ""
    var passwordText: String = ""
    
    // Dependecies
    private let userValidator = Dependencies.container.resolve(UserFieldsValidator.self)!
    private let userdataValidator = Dependencies.container.resolve(UserdataValidator.self)!
    private let keychainUserdata = KeychainUserdataService()
    
    func keychainGetData() -> String {
            return keychainUserdata.getLoginData()
    }
    
    func keychainSaveData() {
        self.keychainUserdata.saveLoginData(username: loginText)
    }
    
    func inputLogin (_ input: String) {
        self.loginText = input
    }
    
    func inputPassword(_ input: String) {
        self.passwordText = input
    }
    
    func buttonSwitcher() -> Bool {
        print(userValidator.loginFieldsCheck(loginText, passwordText))
        if userValidator.loginFieldsCheck(loginText, passwordText) {
            return true
        } else {
            return false
        }
    }
    
    func login (completion: @escaping (String?) -> ()) {
        let login = loginText.trimmingCharacters(in: .whitespacesAndNewlines)
        let pswd = passwordText.trimmingCharacters(in: .whitespacesAndNewlines)
        userdataValidator.userLogIn(email: login, password: pswd) {requestResult in
            completion(requestResult)
        }
    }
    
}
