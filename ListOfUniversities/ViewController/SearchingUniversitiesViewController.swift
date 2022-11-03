//
//  SearchingUniversitiesViewController.swift
//  ListOfUniversities
//
//  Created by Pavel on 3.11.22.
//

import UIKit

var searchResponse: [UniversityModel]? = nil

final class SearchingUniversitiesViewController: UIViewController {
    
    let networkManagerURLSession = NetworkManagerURLSession()
    let networkManagerAlamofire = NetworkManagerAlamofire()
    private var timer: Timer?
    
    let tableView = UITableView(frame: .zero, style: .plain)
    private let cellId = "cellId"
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Search university"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupTableView()
        setupSearchBar()
    }
    
    // MARK: - setup views
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
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    // MARK: - setup search bar
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
    }
}

// MARK: - UITableViewDataSource
extension SearchingUniversitiesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResponse?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchingUniversitiesTableCell
        let track = (searchResponse?[indexPath.row])!
        cell.configureAlbumCell(album: track, index: indexPath.row)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SearchingUniversitiesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UISearchBarDelegate
extension SearchingUniversitiesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let random = Int.random(in: 0...1)
        var urlString = ""
        timer?.invalidate()
        
        // MARK: - URLSession
        if random == 0 {
            urlString = "http://universities.hipolabs.com/search?country=\(searchText.lowercased())"
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
                self.networkManagerURLSession.fetchData(urlString: urlString, completion: { [weak self] (result) in
                    guard let result = result else { return }
                    searchResponse = result
                    self?.tableView.reloadData()
                })
            })
        }
        
        // MARK: - Alamofire
        else {
            urlString = searchText.lowercased()
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
                self.networkManagerAlamofire.fetchData(searchCountry: urlString, completion: { [weak self] (result) in
                    guard let result = result else { return }
                    searchResponse = result
                    self?.tableView.reloadData()
                })
            })
        }
    }
}
