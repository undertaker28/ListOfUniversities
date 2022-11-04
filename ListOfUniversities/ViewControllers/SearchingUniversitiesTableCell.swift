//
//  SearchingUniversitiesTableCell.swift
//  ListOfUniversities
//
//  Created by Pavel on 3.11.22.
//

import UIKit

var indexes = [Int]()

class SearchingUniversitiesTableCell: UITableViewCell {
    lazy var name: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Singleton
    static var shared: SearchingUniversitiesTableCell?
    
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
    
    func configureSearchingUniversitiesTableCell(album: UniversityModel, index: IndexPath.Index) {
        name.text = album.name
        if UserDefaults.standard.bool(forKey: "btn\(index)") {
            let imageFilled = UIImage(systemName: "checkmark.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .light, scale: .large))
            icon.setImage(imageFilled, for: .normal)
            icon.isEnabled = false
        }
        icon.tag = index
    }
    
    @objc func addUniversity(sender: UIButton!) {
        let id = sender.tag
        indexes.append(id)
        print(indexes)
        guard let appendedData = searchResponse else { return }
        ListOfUniversitiesViewController.shared?.universities.append(UniversityModel(domains: appendedData[id].domains, alphaTwoCode: appendedData[id].alphaTwoCode, webPages: appendedData[id].webPages, country: appendedData[id].country, stateProvince: appendedData[id].stateProvince, name: appendedData[id].name))
        UserDefaults.standard.set(true, forKey: "btn\(id)")
        let imageFilled = UIImage(systemName: "checkmark.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .light, scale: .large))
        sender.setImage(imageFilled, for: .normal)
        sender.isEnabled = false
    }
    
    private func makeConstraints() {
        contentView.backgroundColor = .white
        [icon, name].forEach(contentView.addSubview)
        
        icon.snp.makeConstraints { button in
            button.trailing.equalTo(contentView.layoutMarginsGuide)
            button.top.greaterThanOrEqualTo(contentView.layoutMarginsGuide)
            button.bottom.lessThanOrEqualTo(contentView.layoutMarginsGuide)
            button.centerY.equalTo(contentView.snp.centerY)
            button.width.equalTo(30)
            button.height.equalTo(30)
        }
        
        name.snp.makeConstraints { label in
            label.leading.equalTo(contentView.layoutMarginsGuide)
            label.top.greaterThanOrEqualTo(contentView.layoutMarginsGuide)
            label.bottom.lessThanOrEqualTo(contentView.layoutMarginsGuide)
            label.centerY.equalTo(contentView.snp.centerY)
            label.trailing.equalTo(icon.snp.leading).offset(-8)
        }
    }
}
