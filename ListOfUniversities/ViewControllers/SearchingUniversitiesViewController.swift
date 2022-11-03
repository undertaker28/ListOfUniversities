//
//  SearchingUniversitiesViewController.swift
//  ListOfUniversities
//
//  Created by Pavel on 3.11.22.
//

import UIKit

var searchResponse: [UniversityModel]? = nil

final class SearchingUniversitiesViewController: UIViewController {
    lazy var networkManagerURLSession = NetworkManagerURLSession()
    lazy var networkManagerAlamofire = NetworkManagerAlamofire()
    var timer: Timer?
    
    var tableView = UITableView(frame: .zero, style: .plain)
    private let cellId = "cellId"
    
    private lazy var searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Search university"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupTableView()
        setupSearchBar()
    }
    
    private func setupTableView() {
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.backgroundColor = .white
        view.backgroundColor = .white
        
        tableView.register(SearchingUniversitiesTableCell.self, forCellReuseIdentifier: "cell")
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        
        makeConstraints()
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    func makeConstraints() {
        tableView.snp.makeConstraints { table in
            table.top.bottom.trailing.leading.equalToSuperview()
        }
    }
}
