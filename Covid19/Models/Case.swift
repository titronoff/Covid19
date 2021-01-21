//
//  Cases.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 11/15/20.
//

import Foundation

let casesSourceUrl = "https://api.apify.com/v2/key-value-stores/tVaYRsPHLjNdNBu7S/records/LATEST?disableRedirect=true"

struct Case: Decodable {
    var infected: Int?
    var recovered: Int?
    var deceased: Int?
    var updated: String?
    var country: String
    
    init(_ country: String) {
        self.country = country
    }

    private enum CodingKeys: String, CodingKey {
            case infected, recovered, deceased, country, lastUpdatedApify
        }


    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        infected = try? container.decode(Int.self, forKey: .infected)
        recovered = try? container.decode(Int.self, forKey: .recovered)
        deceased = try? container.decode(Int.self, forKey: .deceased)
        updated = try? container.decode(String.self, forKey: .lastUpdatedApify)
        country = try container.decode(String.self, forKey: .country)

    }
}
