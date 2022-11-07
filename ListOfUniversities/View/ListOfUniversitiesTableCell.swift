//
//  ListOfUniversitiesTableCell.swift
//  ListOfUniversities
//
//  Created by Pavel on 3.11.22.
//

import UIKit

class ListOfUniversitiesTableCell: UITableViewCell {
    lazy var link: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var stackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "listOfUniversitiesTableCell")
        
        stackView = UIStackView(arrangedSubviews: [name, link])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .equalCentering
        self.addSubview(stackView)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        stackView.snp.makeConstraints { stack in
            stack.top.equalTo(self.snp.top).offset(10)
            stack.leftMargin.equalToSuperview().offset(10)
            stack.rightMargin.equalToSuperview().offset(-10)
            stack.centerY.equalToSuperview()
            stack.leading.equalToSuperview().offset(10)
            stack.trailing.equalTo(self.snp.trailing).offset(-10)
        }
    }
}
