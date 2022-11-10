//
//  SearchingUniversitiesView.swift
//  ListOfUniversities
//
//  Created by Pavel on 3.11.22.
//

import UIKit

class SearchingUniversitiesView: UIViewController {
    // MARK: - Singleton
    static var shared: SearchingUniversitiesView?
    
    var searchingUniversitiesViewModel = SearchingUniversitiesViewModel()
    
    var tableView = UITableView(frame: .zero, style: .plain)
    
    private lazy var searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SearchingUniversitiesView.shared = self
        self.title = "Search university"
        tableView.tableHeaderView = UIView()
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
        tableView.register(SkeletonCell.self, forCellReuseIdentifier: "skeletonCellId")
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        
        makeConstraints()
    }
    
    func setupSkeletons() {
        let row = UniversityModel.makeSkeleton()
        searchingUniversitiesViewModel.searchResponse = Array(repeating: row, count: 10)
        tableView.reloadData()
        
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    func makeConstraints() {
        tableView.snp.makeConstraints {
            $0.top.bottom.trailing.leading.equalToSuperview()
        }
    }
}

extension SearchingUniversitiesView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: tableView.bounds.width)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SearchingUniversitiesView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchingUniversitiesViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let university = searchingUniversitiesViewModel.searchResponseAtIndex(indexPath.row)
        if searchingUniversitiesViewModel.isLoaded {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchingUniversitiesTableCell
            cell.name.text = university.name
            cell.icon.tag = indexPath.row
            if indexes.contains(where: { $0.key == university.name }) && indexes.contains(where: { $0.value == indexPath.row }) {
                let imageFilled = UIImage(systemName: "checkmark.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .light, scale: .large))
                cell.icon.setImage(imageFilled, for: .normal)
                cell.icon.isEnabled = false
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "skeletonCellId", for: indexPath) as! SkeletonCell
            cell.name.text = university.name
            return cell
        }
    }
}

extension SearchingUniversitiesView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count != 0 {
            self.searchingUniversitiesViewModel.isLoaded = false
            self.setupSkeletons()
            searchingUniversitiesViewModel.getUniversityByCountry(countryName: searchText.lowercased()) {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        } else {
            self.searchingUniversitiesViewModel.isLoaded = true
            self.searchingUniversitiesViewModel.searchResponse = nil
            self.tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchingUniversitiesViewModel.searchResponse = nil
        self.tableView.reloadData()
    }
}
