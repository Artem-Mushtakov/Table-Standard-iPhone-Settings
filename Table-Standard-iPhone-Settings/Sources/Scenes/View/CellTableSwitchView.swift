//
//  CellTableSwitch.swift
//  Table-Settings
//
//  Created by Артем on 24.07.2021.
//

import UIKit

class CellTableSwitchView: BasicCellView {
    
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
    
    lazy var buttonSwitch: UISwitch = {
        let buttonSwitch = UISwitch()
        buttonSwitch.addTarget(self, action: #selector(setupSwitchAction), for:UIControl.Event.valueChanged)
        return buttonSwitch
    } ()
    
    
    // MARK:  - Settings
    
    private func setupHierarchy(){
        addSubview(buttonSwitch)
    }
    
    private func setupLayout() {
        
        buttonSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            buttonSwitch.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            buttonSwitch.rightAnchor.constraint(equalTo: rightAnchor, constant:
                                                    Metric.buttonSwitchRightAnchorConstant)
        ])
    }
    
    @objc func setupSwitchAction(mySwitch: UISwitch) {
        print("Активирован UISwitch: Ячейка Авиарежим")
    }
}

extension CellTableSwitchView {
    
    enum Metric {
        static let buttonSwitchRightAnchorConstant: CGFloat = -20
    }
}
