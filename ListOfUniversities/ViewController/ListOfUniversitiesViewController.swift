//
//  ListOfUniversitiesViewController.swift
//  ListOfUniversities
//
//  Created by Pavel on 3.11.22.
//

import UIKit
import SnapKit

class ListOfUniversitiesViewController: UIViewController {
    
    var tableView = UITableView()
    var universities = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListOfUniversitiesTableCell.self, forCellReuseIdentifier: "listOfUniversitiesTableCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 66

        view.addSubview(tableView)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Universities"
        tableView.tableHeaderView = UIView()
        
        let addBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(addUniversity))
        self.navigationItem.rightBarButtonItem  = addBarButtonItem
        //navigationItem.rightBarButtonItem = rightBarButton
        
        makeConstraints()
    }
    
    @objc func addUniversity(){
        self.present(SearchingUniversitiesViewController(), animated: true)
    }
    
    func makeConstraints() {
        tableView.snp.makeConstraints { tableView in
            tableView.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            tableView.size.height.equalTo(66)
            tableView.size.width.equalToSuperview()
        }
    }
    
}
