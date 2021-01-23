//
//  userdata.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 11/5/20.
//

import Foundation

struct Userdata: Codable {
    var username: String = ""
    var password: String = ""
    var lastLoginDate: Date = Date()
}
