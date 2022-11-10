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
    var networkManagerCombine = NetworkManagerCombine()
    
    var isLoaded = false
    
    var count: Int {
        searchResponse?.count ?? 0
    }
    
    func searchResponseAtIndex(_ index: Int) -> UniversityModel {
        searchResponse?[index] ?? UniversityModel(domains: [], alphaTwoCode: "", webPages: [], country: "", stateProvince: "", name: "")
    }
    
    func getUniversityByCountry(countryName: String, completion: @escaping () -> Void) {
        let choice = Int.random(in: 0...2)
        let urlString = "http://universities.hipolabs.com/search?country=\(countryName)"
        
        if choice == 0 {
            networkResponse(urlString: urlString, networkManager: networkManagerURLSession, completion: completion)
        } else if choice == 1 {
            networkResponse(urlString: urlString, networkManager: networkManagerAlamofire, completion: completion)
        } else {
            networkResponse(urlString: urlString, networkManager: networkManagerCombine, completion: completion)
        }
    }
    
    func networkResponse(urlString: String, networkManager: NetworkOutput, completion: @escaping () -> Void) {
        self.networkManagerURLSession.fetchData(urlString: urlString, completion: { [weak self] (result) in
            guard let result = result else { return }
            if result.count != 0 {
                self?.isLoaded = true
                self?.searchResponse = result
                completion()
            } else {
                self?.searchResponse = nil
            }
        })
    }
}
