//
//  UITableViewDataSource+Extensions.swift
//  ListOfUniversities
//
//  Created by Pavel on 3.11.22.
//

import UIKit

extension ListOfUniversitiesView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfUniversitiesViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listOfUniversitiesTableCell", for: indexPath) as! ListOfUniversitiesTableCell
        cell.accessoryType = .disclosureIndicator
        let link = listOfUniversitiesViewModel.universityAtIndex(indexPath.row).webPages
        cell.link.text = link.first
        let title = listOfUniversitiesViewModel.universityAtIndex(indexPath.row).name
        cell.name.text = title
        return cell
    }
}

extension SearchingUniversitiesView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchingUniversitiesViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let university = searchingUniversitiesViewModel.searchResponseAtIndex(indexPath.row)
        if searchingUniversitiesViewModel.isLoaded {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchingUniversitiesTableCell
            cell.name.text = university.name
            cell.icon.tag = indexPath.row
            if indexes.contains(where: { $0.key == university.name }) && indexes.contains(where: { $0.value == indexPath.row }) {
                let imageFilled = UIImage(systemName: "checkmark.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .light, scale: .large))
                cell.icon.setImage(imageFilled, for: .normal)
                cell.icon.isEnabled = false
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "skeletonCellId", for: indexPath) as! SkeletonCell
            cell.name.text = university.name
            return cell
        }
    }
}
