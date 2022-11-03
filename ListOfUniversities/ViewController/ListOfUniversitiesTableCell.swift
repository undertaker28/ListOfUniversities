//
//  ListOfUniversitiesTableCell.swift
//  ListOfUniversities
//
//  Created by Pavel on 3.11.22.
//

import UIKit

class ListOfUniversitiesTableCell: UITableViewCell {
    var cellImageView = UIImageView()
    var cellLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "listOfUniversitiesTableCell")
        
        cellImageView.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
        cellImageView.contentMode = .scaleAspectFill
        cellImageView.layer.masksToBounds = true
        cellImageView.layer.cornerRadius = cellImageView.bounds.width / 2
        cellImageView.clipsToBounds = true
        
        contentView.addSubview(cellImageView)
        
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        cellLabel.font = UIFont.systemFont(ofSize: 18)
        
        contentView.addSubview(cellLabel)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        cellImageView.snp.makeConstraints { image in
            image.centerY.equalTo(contentView)
            image.size.width.height.equalTo(46)
            image.leading.equalTo(contentView).offset(20)
        }
        
        cellLabel.snp.makeConstraints { label in
            label.centerY.equalTo(contentView)
            label.leading.equalTo(cellImageView.snp.trailing).offset(10)
        }
    }
}
