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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "listOfUniversitiesTableCell", for: indexPath) as? ListOfUniversitiesTableCell else {
            fatalError("Unable to dequeue listOfUniversitiesTableCell")
        }
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}
