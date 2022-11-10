//
//  NetworkOutput.swift
//  ListOfUniversities
//
//  Created by Pavel on 10.11.22.
//

protocol NetworkOutput {
    func fetchData(urlString: String, completion: @escaping ([UniversityModel]?) -> Void)
}
