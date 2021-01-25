//
//  userdata.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 11/5/20.
//

import Foundation

struct Userdata: Codable {
    var uId: String = ""
    var firstName: String = ""
    var lastName: String = ""
    var username: String = ""
    var password: String = ""
    var lastLoginDate: Date = Date()
}

struct UserdataDB: Codable {
    var uId: String = ""
    var lastName: String = ""
    var firstName: String = ""
}
