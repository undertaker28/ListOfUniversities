//
//  SearchingUniversitiesTableCell.swift
//  ListOfUniversities
//
//  Created by Pavel on 3.11.22.
//

import UIKit

class SearchingUniversitiesTableCell: UITableViewCell {
    var searchingUniversitiesViewModel = SearchingUniversitiesViewModel()
    
    lazy var name: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    lazy var icon: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "plus.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .light, scale: .large))
        button.setImage(image, for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.addSubview(name)
        self.addSubview(icon)
        
        icon.addTarget(self, action: #selector(addUniversity), for: .touchUpInside)
    }
    
    @objc func addUniversity(sender: UIButton!) {
        let id = sender.tag
        guard let appendedData = SearchingUniversitiesView.shared?.searchingUniversitiesViewModel.searchResponse else { return }
        searchingUniversitiesViewModel.addUniversity(id: id, appendedUniversity: appendedData[id])
        let imageFilled = UIImage(systemName: "checkmark.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .light, scale: .large))
        sender.setImage(imageFilled, for: .normal)
        sender.isEnabled = false
    }
    
    private func makeConstraints() {
        contentView.backgroundColor = .white
        [icon, name].forEach(contentView.addSubview)
        
        icon.snp.makeConstraints {
            $0.trailing.equalTo(contentView.layoutMarginsGuide)
            $0.top.greaterThanOrEqualTo(contentView.layoutMarginsGuide)
            $0.bottom.lessThanOrEqualTo(contentView.layoutMarginsGuide)
            $0.centerY.equalTo(contentView.snp.centerY)
            $0.width.equalTo(30)
            $0.height.equalTo(30)
        }
        
        name.snp.makeConstraints {
            $0.leading.equalTo(contentView.layoutMarginsGuide)
            $0.top.greaterThanOrEqualTo(contentView.layoutMarginsGuide)
            $0.bottom.lessThanOrEqualTo(contentView.layoutMarginsGuide)
            $0.centerY.equalTo(contentView.snp.centerY)
            $0.trailing.equalTo(icon.snp.leading).offset(-8)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        let image = UIImage(systemName: "plus.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .light, scale: .large))
        self.icon.setImage(image, for: .normal)
        self.icon.isEnabled = true
    }
}
