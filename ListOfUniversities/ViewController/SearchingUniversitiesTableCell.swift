//
//  SearchingUniversitiesTableCell.swift
//  ListOfUniversities
//
//  Created by Pavel on 3.11.22.
//

import UIKit

var indexes = [Int]()

class SearchingUniversitiesTableCell: UITableViewCell {
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private let button: UIButton = {
        let b = UIButton()
        let image = UIImage(systemName: "plus.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .light, scale: .large))
        b.setImage(image, for: .normal)
        return b
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        self.addSubview(label)
        self.addSubview(button)
        
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    func configureAlbumCell(album: UniversityModel, index: IndexPath.Index) {
        label.text = album.name
        if UserDefaults.standard.bool(forKey: "btn\(index)") {
            let imageFilled = UIImage(systemName: "checkmark.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .light, scale: .large))
            button.setImage(imageFilled, for: .normal)
            button.isEnabled = false
        }
        button.tag = index
        //button.isEnabled = true
    }
    
    @objc func buttonAction(sender: UIButton!) {
        let id = sender.tag
        print(id)
        indexes.append(id)
        guard let appendedData = searchResponse else { return }
        
        universities.append(UniversityModel(domains: appendedData[id].domains, alphaTwoCode: appendedData[id].alphaTwoCode, webPages: appendedData[id].webPages, country: appendedData[id].country, stateProvince: appendedData[id].stateProvince, name: appendedData[id].name))
        
        UserDefaults.standard.set(true, forKey: "btn\(id)")
        let imageFilled = UIImage(systemName: "checkmark.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .light, scale: .large))
        sender.setImage(imageFilled, for: .normal)
        sender.isEnabled = false
    }
    
    private func setConstraints() {
        
        contentView.backgroundColor = .white
        [button, label].forEach(contentView.addSubview)
        
        button.snp.makeConstraints { (make) in
            make.trailing.equalTo(contentView.layoutMarginsGuide)
            make.top.greaterThanOrEqualTo(contentView.layoutMarginsGuide)
            make.bottom.lessThanOrEqualTo(contentView.layoutMarginsGuide)
            make.centerY.equalTo(contentView.snp.centerY)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        // constrain label to leading margin
        label.snp.makeConstraints { (make) in
            make.leading.equalTo(contentView.layoutMarginsGuide)
            make.top.greaterThanOrEqualTo(contentView.layoutMarginsGuide)
            make.bottom.lessThanOrEqualTo(contentView.layoutMarginsGuide)
            make.centerY.equalTo(contentView.snp.centerY)
            make.trailing.equalTo(button.snp.leading).offset(-8)
        }
    }
}
