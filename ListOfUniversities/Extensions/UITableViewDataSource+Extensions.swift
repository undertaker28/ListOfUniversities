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
        let university = (searchResponse?[indexPath.row]) ?? UniversityModel(domains: [], alphaTwoCode: "", webPages: [], country: "", stateProvince: "", name: "")
        if loaded {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchingUniversitiesTableCell
            cell.name.text = university.name
            cell.icon.tag = indexPath.row
            if indexes.contains(indexPath.row) {
                print(indexPath.row)
                let imageFilled = UIImage(systemName: "checkmark.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .light, scale: .large))
                cell.icon.setImage(imageFilled, for: .normal)
                cell.icon.isEnabled = false
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: skeletonCellId, for: indexPath) as! SkeletonCell
            cell.name.text = university.name
            return cell
        }
    }
}
