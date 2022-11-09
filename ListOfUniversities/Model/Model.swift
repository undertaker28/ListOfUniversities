//
//  Model.swift
//  ListOfUniversities
//
//  Created by Pavel on 3.11.22.
//

import Foundation

struct UniversityModel: Codable {
    let domains: [String]
    let alphaTwoCode: String
    let webPages: [String]
    let country: String
    let stateProvince: String?
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case domains
        case alphaTwoCode = "alpha_two_code"
        case webPages = "web_pages"
        case country
        case stateProvince = "state-province"
        case name
    }
    
    static func makeSkeleton() -> UniversityModel {
        return UniversityModel(domains: [], alphaTwoCode: "", webPages: [], country: "", stateProvince: "", name: "      ")
    }
}
