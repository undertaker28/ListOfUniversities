//
//  UniversityDetailViewController.swift
//  ListOfUniversities
//
//  Created by Pavel on 3.11.22.
//

import UIKit
import SnapKit

class UniversityDetailViewController: UIViewController {
    var name = ""
    var country = ""
    var domain = ""
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private let countryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private let domainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    var stackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        nameLabel.text = "Name: \(name)"
        countryLabel.text = "Country: \(country)"
        domainLabel.text = "Domain: \(domain)"
        
        stackView = UIStackView(arrangedSubviews: [nameLabel, countryLabel, domainLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fill
        view.addSubview(stackView)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "University info"
        
        makeConstraints()
    }
    
    func makeConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.leftMargin.equalToSuperview()
            make.rightMargin.equalToSuperview()
        }
    }
    
}
