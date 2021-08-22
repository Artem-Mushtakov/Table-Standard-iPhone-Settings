//
//  CellView.swift
//  Table-Standard-iPhone-Settings
//
//  Created by Артем on 22.08.2021.
//

import UIKit

class CellView: UIView {
    
    var model: CellModel?
    
    // MARK: - Configuration
    
    func configureView(with models: [String: [Cell]]) {
        setupHierarchy()
        setupLayout()
        
    }
    
    // MARK: - Views
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = CGFloat(10)
        view.distribution = .equalSpacing
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(BasicCellView.self, forCellReuseIdentifier: "BasicCellView")
        tableView.register(CellTableSwitchView.self, forCellReuseIdentifier: "CellTableSwitchView")
        tableView.register(CellTableRightLabelView.self, forCellReuseIdentifier: "CellTableRightLabelView")
        
        return tableView
    }()
    
//    // MARK: - Lifecycle
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        setupHierarchy()
//        setupLayout()
//        navigationItem.title = "Настройки"
//    }
    
    // MARK:  - Settings
    
    private func setupHierarchy(){
        stackView.addSubview(tableView)
    }
    
    func setupLayout() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: stackView.topAnchor),
            tableView.leftAnchor.constraint(equalTo: stackView.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: stackView.rightAnchor)
        ])
    }
}

extension CellView: UITableViewDataSource, UITableViewDelegate {
    
    // Количество секций
    
    func numberOfSections(in tableView: UITableView) -> Int {
        model?.createCellModel().keys.count ?? 0
    }
    
    // Количество ячеек в секции
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model?.createCellModel()["Section\(section)"]?.count ?? 0
    }
    
    // Получение объекта ячейки
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let data = model?.createCellModel()["Section\(indexPath.section)"]?[indexPath.row].type else { return UITableViewCell() }
        
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
         
        print("Нажата ячейка \(model?.createCellModel()["Section\(indexPath.section)"]?[indexPath.row].title ?? "Отсутствует значение")")
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // Функция настройки ячейки
    
    private  func setupBasicCell(for indexPath: IndexPath, with data: CellType) -> UITableViewCell {
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCellView", for: indexPath) as? BasicCellView
        else { return UITableViewCell() }
        
        cell.titleLabel.text = model?.createCellModel()["Section\(indexPath.section)"]?[indexPath.row].title
        cell.iconImage.image = model?.createCellModel()["Section\(indexPath.section)"]?[indexPath.row].image
        
        return cell
    }
    
    // Функция настройки ячейки
    
    private  func setupCellTableSwitch(for indexPath: IndexPath, with data: CellType) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellTableSwitchView", for: indexPath) as? CellTableSwitchView
        else { return UITableViewCell() }
        
        cell.titleLabel.text = model?.createCellModel()["Section\(indexPath.section)"]?[indexPath.row].title
        cell.iconImage.image = model?.createCellModel()["Section\(indexPath.section)"]?[indexPath.row].image
        cell.accessoryView = cell.buttonSwitch
        
        return cell
    }
    
    // Функция настройки ячейки
    
    private  func setupCellTableRightLabel(for indexPath: IndexPath, with data: CellType) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellTableRightLabelView", for: indexPath) as? CellTableRightLabelView
        else { return UITableViewCell() }
        
        cell.titleLabel.text = model?.createCellModel()["Section\(indexPath.section)"]?[indexPath.row].title
        cell.iconImage.image = model?.createCellModel()["Section\(indexPath.section)"]?[indexPath.row].image
        cell.rightLabel.text = model?.createCellModel()["Section\(indexPath.section)"]?[indexPath.row].rightLabel
        
        return cell
    }
}

