//
//  ListOfUniversitiesViewController.swift
//  ListOfUniversities
//
//  Created by Pavel on 3.11.22.
//

import UIKit
import SnapKit

var universities = [UniversityModel]()

class ListOfUniversitiesViewController: UIViewController {
    
    var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //universities.append(UniversityModel(domains: ["dad"], alphaTwoCode: "dad", webPages: ["dad"], country: "dad", stateProvince: "dad", name: "dad"))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListOfUniversitiesTableCell.self, forCellReuseIdentifier: "listOfUniversitiesTableCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100

        view.addSubview(tableView)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Universities"
        tableView.tableHeaderView = UIView()
        
        let addBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(addUniversity))
        self.navigationItem.rightBarButtonItem = addBarButtonItem
        //navigationItem.rightBarButtonItem = rightBarButton
        
        makeConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(indexes)
        tableView.reloadData()
    }
    
    @objc func addUniversity(){
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(SearchingUniversitiesViewController(), animated: true)
            //self.present(SearchingUniversitiesViewController(), animated: true)
        }
    }
    
    func makeConstraints() {
        tableView.snp.makeConstraints { tableView in
            tableView.top.bottom.trailing.leading.equalToSuperview()
        }
    }
    
}
