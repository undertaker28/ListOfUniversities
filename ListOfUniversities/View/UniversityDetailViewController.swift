//
//  UniversityDetailView.swift
//  ListOfUniversities
//
//  Created by Pavel on 3.11.22.
//

import UIKit

class UniversityDetailView: UIViewController {
    var universityDetailViewModel = UniversityDetailViewModel()
    
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
        nameLabel.text = "Name: \(universityDetailViewModel.name)"
        countryLabel.text = "Country: \(universityDetailViewModel.country)"
        domainLabel.text = "Domain: \(universityDetailViewModel.domain)"
        
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
        stackView.snp.makeConstraints { stack in
            stack.top.equalToSuperview().offset(150)
            stack.leftMargin.equalToSuperview()
            stack.rightMargin.equalToSuperview()
        }
    }
    
}
