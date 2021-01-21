//
//  UserValidator.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 14.01.21.
//

import Foundation

protocol UserFieldsValidator {
    func loginFieldsCheck(_ usernameText: String, _  passwordText: String) -> Bool
}
