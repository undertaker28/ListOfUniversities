//
//  SearchingUniversitiesViewController.swift
//  ListOfUniversities
//
//  Created by Pavel on 3.11.22.
//

import UIKit

final class SearchingUniversitiesViewController: UIViewController {
    lazy var networkManagerURLSession = NetworkManagerURLSession()
    lazy var networkManagerAlamofire = NetworkManagerAlamofire()
    
    // MARK: - Singleton
    static var shared: SearchingUniversitiesViewController?
    
    var searchResponse: [UniversityModel]? = nil
    
    var tableView = UITableView(frame: .zero, style: .plain)
    let cellId = "cellId"
    let skeletonCellId = "skeletonCellId"
    
    var loaded = false
    
    private lazy var searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SearchingUniversitiesViewController.shared = self
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
        tableView.register(SkeletonCell.self, forCellReuseIdentifier: skeletonCellId)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        
        makeConstraints()
    }
    
    func setupSkeletons() {
        let row = UniversityModel.makeSkeleton()
        searchResponse = Array(repeating: row, count: 10)
        tableView.reloadData()
        
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
