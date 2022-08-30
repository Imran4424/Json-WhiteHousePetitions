//
//  Petitions.swift
//  WhiteHousePetitions
//
//  Created by Shah Md Imran Hossain on 31/8/22.
//

import Foundation

struct Petitions: Codable {
    // Codable properties need to be named as json property name
    // otherwise parsing will fail
    var results: [Petition]
}
