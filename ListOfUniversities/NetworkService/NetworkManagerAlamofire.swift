//
//  NetworkManagerAlamofire.swift
//  ListOfUniversities
//
//  Created by Pavel on 4.11.22.
//

import Alamofire

class NetworkManagerAlamofire: NetworkOutput {
    func fetchData(urlString: String, completion: @escaping ([UniversityModel]?) -> Void) {
        AF.request(
            String(urlString.prefix(40)), method: .get,
            parameters: ["country": urlString.suffix(from: urlString.index(urlString.startIndex, offsetBy: 48))])
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
