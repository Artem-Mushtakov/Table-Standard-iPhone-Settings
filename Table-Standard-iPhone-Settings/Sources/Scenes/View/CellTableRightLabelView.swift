//
//  CellTableRightLabel.swift
//  Table-Settings
//
//  Created by Артем on 25.07.2021.
//

import UIKit

class CellTableRightLabelView: BasicCellView {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Views

    lazy var rightLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = NSTextAlignment.right
        
        return label
    } ()
    
    // MARK:  - Settings
    
    private func setupHierarchy(){
        addSubview(rightLabel)
    }
    
    private func setupLayout() {
        
        rightLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rightLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            rightLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -40)
        ])
    }
    
}
