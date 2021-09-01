//
//  BasicCell.swift
//  Table-Standard-iPhone-Settings
//
//  Created by Артем on 24.07.2021.
//

import UIKit

class BasicCellView: UITableViewCell {
    
    // MARK: - Initial
    
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
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant:
                                                Metric.titleLabelLeftAnchorConstant),
            
            iconImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImage.leftAnchor.constraint(equalTo: leftAnchor, constant:
                                                Metric.iconImageLeftAnchorConstant),
            iconImage.widthAnchor.constraint(equalToConstant:
                                                Metric.iconImageWidthAnchorConstant),
            iconImage.heightAnchor.constraint(equalToConstant:
                                                Metric.iconImageHeightAnchorConstant),
            
            actionRightImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            actionRightImage.rightAnchor.constraint(equalTo: rightAnchor, constant:
                                                        Metric.actionRightImageRightAnchorConstant),
            actionRightImage.widthAnchor.constraint(equalToConstant:
                                                        Metric.actionRightImageWidthAnchorConstant),
            actionRightImage.heightAnchor.constraint(equalToConstant:
                                                        Metric.actionRightImageHeightAnchorConstant)
        ])
    }
}

extension BasicCellView {
    
    enum Metric {
        static let labelFont: UIFont = .systemFont(ofSize: 17)
        
        static var titleLabelLeftAnchorConstant: CGFloat = 60
        
        static var iconImageLeftAnchorConstant: CGFloat = 15
        static var iconImageWidthAnchorConstant: CGFloat = 28
        static var iconImageHeightAnchorConstant: CGFloat = 28
        
        static var actionRightImageRightAnchorConstant: CGFloat = -20
        static var actionRightImageWidthAnchorConstant: CGFloat = 6
        static var actionRightImageHeightAnchorConstant: CGFloat = 10
    }
}
