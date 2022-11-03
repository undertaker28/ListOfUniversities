//
//  UISearchBarDelegate+Extensions.swift
//  ListOfUniversities
//
//  Created by Pavel on 4.11.22.
//

import UIKit

extension SearchingUniversitiesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let choice = Int.random(in: 0...1)
        var urlString = ""
        timer?.invalidate()
        
        // MARK: - URLSession
        if choice == 0 {
            urlString = "http://universities.hipolabs.com/search?country=\(searchText.lowercased())"
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
                self.networkManagerURLSession.fetchData(urlString: urlString, completion: { [weak self] (result) in
                    guard let result = result else { return }
                    searchResponse = result
                    self?.tableView.reloadData()
                })
            })
        }
        
        // MARK: - Alamofire
        else {
            urlString = searchText.lowercased()
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
                self.networkManagerAlamofire.fetchData(searchCountry: urlString, completion: { [weak self] (result) in
                    guard let result = result else { return }
                    searchResponse = result
                    self?.tableView.reloadData()
                })
            })
        }
    }
}
