//
//  AddedUniversityModel.swift
//  ListOfUniversities
//
//  Created by Pavel on 10.11.22.
//

import Foundation

struct AddedUniversityModel: Codable {
    let id: Int
    let webPage: String
    let name: String
    let country: String
    let domain: String
}
