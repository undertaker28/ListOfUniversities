//
//  NetworkManagerURLSession.swift
//  ListOfUniversities
//
//  Created by Pavel on 3.11.22.
//

import Foundation

protocol NetworkOutputURLSession {
    func fetchData(urlString: String, completion: @escaping ([UniversityModel]?) -> Void)
}

class NetworkManagerURLSession: NetworkOutputURLSession {
    func fetchData(urlString: String, completion: @escaping ([UniversityModel]?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard error == nil else { return }
                guard let data = data else { return }
                do {
                    let universities = try JSONDecoder().decode([UniversityModel].self, from: data)
                    completion(universities)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    completion(nil)
                }
            }
        }.resume()
    }
}
