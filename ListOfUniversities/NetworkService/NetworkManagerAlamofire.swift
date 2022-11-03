//
//  NetworkManagerAlamofire.swift
//  ListOfUniversities
//
//  Created by Pavel on 4.11.22.
//

import Alamofire

protocol NetworkOutputAlamofire {
    func fetchData(searchCountry: String, completion: @escaping ([UniversityModel]?) -> Void)
}

class NetworkManagerAlamofire: NetworkOutputAlamofire {
    func fetchData(searchCountry: String, completion: @escaping ([UniversityModel]?) -> Void) {
        AF.request(
            "http://universities.hipolabs.com/search?", method: .get,
            parameters: ["country": searchCountry])
        .validate()
        .responseData() { response in
            switch response.result {
            case .success(let data):
                do {
                    let universities = try JSONDecoder().decode([UniversityModel].self, from: data)
                    completion(universities)
                } catch {
                    return
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
