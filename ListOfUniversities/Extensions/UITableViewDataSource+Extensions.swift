//
//  UITableViewDataSource+Extensions.swift
//  ListOfUniversities
//
//  Created by Pavel on 3.11.22.
//

import UIKit

extension ListOfUniversitiesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return universities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listOfUniversitiesTableCell", for: indexPath) as! ListOfUniversitiesTableCell
        cell.accessoryType = .disclosureIndicator
        let link = universities[indexPath.row].webPages
        cell.link.text = link.first
        let title = universities[indexPath.row].name
        cell.name.text = title
        return cell
    }
}

extension SearchingUniversitiesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResponse?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchingUniversitiesTableCell
        let track = (searchResponse?[indexPath.row])!
        cell.configureSearchingUniversitiesTableCell(album: track, index: indexPath.row)
        return cell
    }
}
