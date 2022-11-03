//
//  UITableViewDelegate+Extensions.swift
//  ListOfUniversities
//
//  Created by Pavel on 3.11.22.
//

import UIKit

extension ListOfUniversitiesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsViewController = UniversityDetailViewController()
        detailsViewController.name = universities[indexPath.row].name
        detailsViewController.country = universities[indexPath.row].country
        detailsViewController.domain = universities[indexPath.row].domains.first!
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            universities.remove(at: indexPath.row)
            print(indexes[indexPath.row])
            UserDefaults.standard.set(false, forKey: "btn\(indexes[indexPath.row])")
            indexes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
