//
//  UITableViewDelegate+Extensions.swift
//  ListOfUniversities
//
//  Created by Pavel on 3.11.22.
//

import UIKit

extension ListOfUniversitiesView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsViewController = UniversityDetailView()
        detailsViewController.universityDetailViewModel.name = listOfUniversitiesViewModel.universityAtIndex(indexPath.row).name
        detailsViewController.universityDetailViewModel.country = listOfUniversitiesViewModel.universityAtIndex(indexPath.row).country
        detailsViewController.universityDetailViewModel.domain = listOfUniversitiesViewModel.universityAtIndex(indexPath.row).domains.first!
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            indexes[listOfUniversitiesViewModel.universityAtIndex(indexPath.row).name] = nil
            listOfUniversitiesViewModel.removeUniversityAtIndex(indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

extension SearchingUniversitiesView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
