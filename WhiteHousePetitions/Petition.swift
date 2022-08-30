//
//  Petition.swift
//  WhiteHousePetitions
//
//  Created by Shah Md Imran Hossain on 30/8/22.
//

import Foundation

struct Petition: Codable {
    // Codable properties need to be named as json property name
    // otherwise parsing will fail
    var title: String
    var body: String
    var signatureCount: Int
}
