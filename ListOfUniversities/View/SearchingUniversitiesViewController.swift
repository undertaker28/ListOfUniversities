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
        tableView.snp.makeConstraints { table in
            table.top.bottom.trailing.leading.equalToSuperview()
        }
    }
}

extension SearchingUniversitiesView: UITableViewDelegate {
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
        let choice = Int.random(in: 0...1)
        var urlString = ""
        
        if searchText.count != 0 {
            self.searchingUniversitiesViewModel.isLoaded = false
            self.setupSkeletons()
        } else {
            self.searchingUniversitiesViewModel.isLoaded = true
            self.searchingUniversitiesViewModel.searchResponse = nil
            self.tableView.reloadData()
        }
        
        // MARK: - URLSession
        if choice == 0 {
            urlString = "http://universities.hipolabs.com/search?country=\(searchText.lowercased())"
            self.searchingUniversitiesViewModel.networkManagerURLSession.fetchData(urlString: urlString, completion: { [weak self] (result) in
                guard let result = result else { return }
                if result.count != 0 {
                    self?.searchingUniversitiesViewModel.isLoaded = true
                    self?.searchingUniversitiesViewModel.searchResponse = result
                    self?.tableView.reloadData()
                } else {
                    self?.searchingUniversitiesViewModel.searchResponse = nil
                }
            })
        }
        
        // MARK: - Alamofire
        else {
            urlString = searchText.lowercased()
            self.searchingUniversitiesViewModel.networkManagerAlamofire.fetchData(searchCountry: urlString, completion: { [weak self] (result) in
                guard let result = result else { return }
                if result.count != 0 {
                    self?.searchingUniversitiesViewModel.isLoaded = true
                    self?.searchingUniversitiesViewModel.searchResponse = result
                    self?.tableView.reloadData()
                } else {
                    self?.searchingUniversitiesViewModel.searchResponse = nil
                }
            })
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchingUniversitiesViewModel.searchResponse = nil
        self.tableView.reloadData()
    }
}
