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
        cell.cellLink.text = link.first
        
        let title = universities[indexPath.row].name
        cell.cellLabel.text = title
        return cell
    }
}
