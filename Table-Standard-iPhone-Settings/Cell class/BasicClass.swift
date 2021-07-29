//
//  BasicCell.swift
//  Table-Standard-iPhone-Settings
//
//  Created by Артем on 24.07.2021.
//

import UIKit

class BasicCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Views
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    } ()
    
    lazy var iconImage: UIImageView = {
        let image = UIImageView()
        return image
    } ()
    
    lazy var actionRightImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(imageLiteralResourceName: "moreThan")
    
        return image
    } ()
    
    // MARK:  - Settings
    
    private func setupHierarchy(){
        addSubview(titleLabel)
        addSubview(iconImage)
        addSubview(actionRightImage)
    }
    
    private func setupLayout() {
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        actionRightImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 60),
            
            iconImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            iconImage.widthAnchor.constraint(equalToConstant: 28),
            iconImage.heightAnchor.constraint(equalToConstant: 28),
            
            actionRightImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            actionRightImage.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            actionRightImage.widthAnchor.constraint(equalToConstant: 6),
            actionRightImage.heightAnchor.constraint(equalToConstant: 10)
        ])
    }
    
}
