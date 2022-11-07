//
//  UISearchBarDelegate+Extensions.swift
//  ListOfUniversities
//
//  Created by Pavel on 4.11.22.
//

import UIKit

extension SearchingUniversitiesView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let choice = Int.random(in: 0...1)
        var urlString = ""
        
        if searchText.count != 0 {
            self.searchingUniversitiesViewModel.isLoaded = false
            self.setupSkeletons()
        } else {
            self.searchingUniversitiesViewModel.isLoaded = true
            self.searchingUniversitiesViewModel.searchResponse = nil
            self.tableView.reloadData()
        }
        
        // MARK: - URLSession
        if choice == 0 {
            urlString = "http://universities.hipolabs.com/search?country=\(searchText.lowercased())"
            self.searchingUniversitiesViewModel.networkManagerURLSession.fetchData(urlString: urlString, completion: { [weak self] (result) in
                guard let result = result else { return }
                if result.count != 0 {
                    self?.searchingUniversitiesViewModel.isLoaded = true
                    self?.searchingUniversitiesViewModel.searchResponse = result
                    self?.tableView.reloadData()
                } else {
                    self?.searchingUniversitiesViewModel.searchResponse = nil
                }
            })
        }
        
        // MARK: - Alamofire
        else {
            urlString = searchText.lowercased()
            self.searchingUniversitiesViewModel.networkManagerAlamofire.fetchData(searchCountry: urlString, completion: { [weak self] (result) in
                guard let result = result else { return }
                if result.count != 0 {
                    self?.searchingUniversitiesViewModel.isLoaded = true
                    self?.searchingUniversitiesViewModel.searchResponse = result
                    self?.tableView.reloadData()
                } else {
                    self?.searchingUniversitiesViewModel.searchResponse = nil
                }
            })
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchingUniversitiesViewModel.searchResponse = nil
        self.tableView.reloadData()
    }
}
