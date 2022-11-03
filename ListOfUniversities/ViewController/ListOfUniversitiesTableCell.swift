//
//  ListOfUniversitiesTableCell.swift
//  ListOfUniversities
//
//  Created by Pavel on 3.11.22.
//

import UIKit

class ListOfUniversitiesTableCell: UITableViewCell {
    let cellLink: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    let cellLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    var stackView = UIStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "listOfUniversitiesTableCell")
        
        stackView = UIStackView(arrangedSubviews: [cellLabel, cellLink])
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
        stackView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(10)
            make.leftMargin.equalToSuperview().offset(10)
            make.rightMargin.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalTo(self.snp.trailing).offset(-10)
        }
    }
}
