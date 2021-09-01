//
//  CellView.swift
//  Table-Standard-iPhone-Settings
//
//  Created by Артем on 22.08.2021.
//

import UIKit

class CellView: UIView {
    
    // MARK: - Properties
    
    var model = CellModel()
    
    // MARK: - Configuration
    
    func configureView(with models: [String: [Cell]]) {
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Views
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(BasicCellView.self, forCellReuseIdentifier: "BasicCellView")
        tableView.register(CellTableSwitchView.self, forCellReuseIdentifier: "CellTableSwitchView")
        tableView.register(CellTableRightLabelView.self, forCellReuseIdentifier: "CellTableRightLabelView")
        
        return tableView
    }()
    
    // MARK:  - Settings
    
    private func setupHierarchy(){
        addSubview(tableView)
    }
    
    func setupLayout() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension CellView: UITableViewDataSource, UITableViewDelegate {
    
    // Количество секций
    
    func numberOfSections(in tableView: UITableView) -> Int {
        model.createCellModel().keys.count
    }
    
    // Количество ячеек в секции
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.createCellModel()["Section\(section)"]?.count ?? 0
    }
    
    // Получение объекта ячейки
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let data = model.createCellModel()["Section\(indexPath.section)"]?[indexPath.row].type else { return UITableViewCell() }
        
        switch data {
        case .basicCell:
            return setupBasicCell(for: indexPath, with: data)
        case .cellTableSwitch:
            return setupCellTableSwitch(for: indexPath, with: data)
        case .cellTableRightLabel:
            return setupCellTableRightLabel(for: indexPath, with: data)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("Нажата ячейка \(model.createCellModel()["Section\(indexPath.section)"]?[indexPath.row].title ?? "Отсутствует значение")")
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // Функция настройки ячейки
    
    private  func setupBasicCell(for indexPath: IndexPath, with data: CellType) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCellView", for: indexPath) as? BasicCellView
        else { return UITableViewCell() }
        
        let data = model.createCellModel()["Section\(indexPath.section)"]?[indexPath.row]
        cell.titleLabel.text = data?.title
        cell.iconImage.image = data?.image
        
        return cell
    }
    
    // Функция настройки ячейки
    
    private  func setupCellTableSwitch(for indexPath: IndexPath, with data: CellType) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellTableSwitchView", for: indexPath) as? CellTableSwitchView
        else { return UITableViewCell() }
        
        let data = model.createCellModel()["Section\(indexPath.section)"]?[indexPath.row]
        cell.titleLabel.text = data?.title
        cell.iconImage.image = data?.image
        cell.accessoryView = cell.buttonSwitch
        
        return cell
    }
    
    // Функция настройки ячейки
    
    private  func setupCellTableRightLabel(for indexPath: IndexPath, with data: CellType) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellTableRightLabelView", for: indexPath) as? CellTableRightLabelView
        else { return UITableViewCell() }
        
        let data = model.createCellModel()["Section\(indexPath.section)"]?[indexPath.row]
        cell.titleLabel.text = data?.title
        cell.iconImage.image = data?.image
        cell.rightLabel.text = data?.rightLabel
        
        return cell
    }
}

