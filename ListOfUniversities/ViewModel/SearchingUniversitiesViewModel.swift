//
//  SearchingUniversitiesViewModel.swift
//  ListOfUniversities
//
//  Created by Pavel on 7.11.22.
//

class SearchingUniversitiesViewModel {
    var searchResponse: [UniversityModel]? = nil
    var networkManagerURLSession = NetworkManagerURLSession()
    var networkManagerAlamofire = NetworkManagerAlamofire()
    
    var isLoaded = false
    
    var count: Int {
        searchResponse?.count ?? 0
    }
    
    func searchResponseAtIndex(_ index: Int) -> UniversityModel {
        searchResponse?[index] ?? UniversityModel(domains: [], alphaTwoCode: "", webPages: [], country: "", stateProvince: "", name: "")
    }
}
