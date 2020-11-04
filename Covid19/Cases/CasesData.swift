//
//  CasesData.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 11/1/20.
//

import UIKit

 struct Country {
    var country: String
    var latest: Latest
    
    init (_ name: String, _ latest: Latest) {
        self.country = name
        self.latest = latest
    }
}

 struct Latest {
    var confirmed: Int
    var deaths: Int
    init(_ confirmed: Int, _ deaths: Int) {
        self.confirmed = confirmed
        self.deaths = deaths
    }
}
var allCountries = [Country]()

func getCases() {
    allCountries.append(Country("USA", Latest(100, 12)))
    allCountries.append(Country("Canada", Latest(15, 4)))
    allCountries.append(Country("China", Latest(130, 17)))
    allCountries.append(Country("Russia", Latest(45, 7)))
}
