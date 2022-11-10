//
//  UniversityDetailView.swift
//  ListOfUniversities
//
//  Created by Pavel on 3.11.22.
//

import UIKit

class UniversityDetailView: UIViewController {
    var universityDetailViewModel: UniversityDetailViewModel
    
    init(name: String, domain: String, country: String) {
        universityDetailViewModel = UniversityDetailViewModel(name: name, domain: domain, country: country)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var countryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var domainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupStackView()
        setupNavigationBar()
        makeConstraints()
    }
    
    private func setupStackView() {
        nameLabel.text = "Name: \(universityDetailViewModel.getName())"
        countryLabel.text = "Country: \(universityDetailViewModel.getCountry())"
        domainLabel.text = "Domain: \(universityDetailViewModel.getDomain())"
        
        stackView = UIStackView(arrangedSubviews: [nameLabel, countryLabel, domainLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fill
        
        view.addSubview(stackView)
        
        makeConstraints()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "University info"
    }
    
    func makeConstraints() {
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(150)
            $0.leftMargin.equalToSuperview()
            $0.rightMargin.equalToSuperview()
        }
    }
}
