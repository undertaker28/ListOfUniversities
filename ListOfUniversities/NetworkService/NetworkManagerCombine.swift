//
//  NetworkManagerCombine.swift
//  ListOfUniversities
//
//  Created by Pavel on 10.11.22.
//

import Foundation
import Combine

enum HTTPError: LocalizedError {
    case statusCode
}

class NetworkManagerCombine: NetworkOutput {
    var cancellable: AnyCancellable?
    
    func fetchData(urlString: String, completion: @escaping ([UniversityModel]?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw HTTPError.statusCode
                }
                return output.data
            }
            .decode(type: [UniversityModel].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }, receiveValue: { data in
                DispatchQueue.main.async {
                    completion(data)
                }
            })
    }
}
