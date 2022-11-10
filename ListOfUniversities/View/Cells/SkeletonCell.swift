//
//  SkeletonCell.swift
//  ListOfUniversities
//
//  Created by Pavel on 5.11.22.
//

import UIKit

class SkeletonCell: UITableViewCell, SkeletonLoadable {
    lazy var name: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    let nameLayer = CAGradientLayer()

    lazy var icon: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "plus.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .light, scale: .large))
        button.setImage(image, for: .normal)
        return button
    }()
    let iconLayer = CAGradientLayer()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        name.translatesAutoresizingMaskIntoConstraints = false
        icon.translatesAutoresizingMaskIntoConstraints = false
        
        nameLayer.startPoint = CGPoint(x: 0, y: 0.5)
        nameLayer.endPoint = CGPoint(x: 1, y: 0.5)
        name.layer.addSublayer(nameLayer)

        iconLayer.startPoint = CGPoint(x: 0, y: 0.5)
        iconLayer.endPoint = CGPoint(x: 1, y: 0.5)
        icon.layer.addSublayer(iconLayer)

        let titleGroup = makeAnimationGroup()
        titleGroup.beginTime = 0.0
        nameLayer.add(titleGroup, forKey: "backgroundColor")
        
        let yearGroup = makeAnimationGroup(previousGroup: titleGroup)
        iconLayer.add(yearGroup, forKey: "backgroundColor")
    }
    
    func layout() {
        addSubview(name)
        addSubview(icon)
        
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLayer.frame = name.bounds
        nameLayer.cornerRadius = name.bounds.height / 2
        
        iconLayer.frame = icon.bounds
        iconLayer.cornerRadius = icon.bounds.height / 2
    }
}
