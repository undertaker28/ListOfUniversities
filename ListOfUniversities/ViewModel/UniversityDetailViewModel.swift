//
//  UniversityDetailViewModel.swift
//  ListOfUniversities
//
//  Created by Pavel on 7.11.22.
//

class UniversityDetailViewModel {
    var name = ""
    var country = ""
    var domain = ""
    
    init(name: String, domain: String, country: String) {
        self.name = name
        self.country = country
        self.domain = domain
    }
    
    func getName() -> String {
        name
    }
    
    func getDomain() -> String {
        domain
    }
    
    func getCountry() -> String {
        country
    }
}
