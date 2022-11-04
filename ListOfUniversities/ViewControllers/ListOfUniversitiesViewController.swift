//
//  ListOfUniversitiesViewController.swift
//  ListOfUniversities
//
//  Created by Pavel on 3.11.22.
//

import UIKit
import SnapKit

class ListOfUniversitiesViewController: UIViewController {
    // MARK: - Singleton
    static var shared: ListOfUniversitiesViewController?
    
    var tableView = UITableView()
    var universities = [UniversityModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        ListOfUniversitiesViewController.shared = self
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
        self.navigationController?.pushViewController(SearchingUniversitiesViewController(), animated: true)
    }
    
    func makeConstraints() {
        tableView.snp.makeConstraints { table in
            table.top.bottom.trailing.leading.equalToSuperview()
        }
    }
}
