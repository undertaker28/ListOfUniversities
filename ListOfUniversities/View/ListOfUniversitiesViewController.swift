//
//  ListOfUniversitiesView.swift
//  ListOfUniversities
//
//  Created by Pavel on 3.11.22.
//

import UIKit
import SnapKit

class ListOfUniversitiesView: UIViewController {
    // MARK: - Singleton
    static var shared: ListOfUniversitiesView?
    
    var tableView = UITableView()
    var listOfUniversitiesViewModel = ListOfUniversitiesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        ListOfUniversitiesView.shared = self
        setupTableView()
        setupBarButtonItem()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListOfUniversitiesTableCell.self, forCellReuseIdentifier: "listOfUniversitiesTableCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Universities"
        tableView.tableHeaderView = UIView()
        
        makeConstraints()
    }
    
    private func setupBarButtonItem() {
        let addBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(searchingUniversities))
        self.navigationItem.rightBarButtonItem = addBarButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @objc func searchingUniversities(){
        self.navigationController?.pushViewController(SearchingUniversitiesView(), animated: true)
    }
    
    func makeConstraints() {
        tableView.snp.makeConstraints { table in
            table.top.bottom.trailing.leading.equalToSuperview()
        }
    }
}

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
