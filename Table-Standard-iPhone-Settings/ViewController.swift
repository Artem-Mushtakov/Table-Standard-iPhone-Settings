//
//  ViewController.swift
//  Table-Settings
//
//  Created by Артем on 23.07.2021.
//

import UIKit

enum CellType {
    case basicCell
    case cellTableSwitch
    case cellTableRightLabel
}

struct CellModel {
    let type: CellType
    var image: UIImage
    let title: String
    var rightLabel: String? = nil
}

class ViewController: UIViewController {
    
    var data = [ "Section0": [CellModel(
                                type: .cellTableSwitch,
                                image: (UIImage(systemName: "airplane")?.withTintColor(.orange, renderingMode: .alwaysOriginal)) ?? .add,
                                title: "Авиарежим"),
                              CellModel(
                                type: .cellTableRightLabel,
                                image: UIImage(systemName: "wifi") ?? .add ,
                                title: "Wi-Fi", rightLabel: "Не подключено"),
                              CellModel(
                                type: .cellTableRightLabel,
                                image: UIImage(named: "bluetooth") ?? .add,
                                title: "Bluetooth", rightLabel: "Вкл."),
                              CellModel(
                                type: .basicCell,
                                image: UIImage(systemName: "antenna.radiowaves.left.and.right")?.withTintColor(.green, renderingMode: .alwaysOriginal) ?? .add,
                                title: "Сотовая связь"),
                              CellModel(
                                type: .basicCell,
                                image: UIImage(named: "personalhotspot")?.withTintColor(.green, renderingMode: .alwaysOriginal) ?? .add,
                                title: "Режим модема"),],
                 "Section1": [CellModel(
                                type: .basicCell,
                                image: UIImage(systemName: "dot.square.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal) ?? .add,
                                title: "Уведомления"),
                              CellModel(
                                type: .basicCell,
                                image: UIImage(systemName: "speaker.wave.2.fill")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal) ?? .add,
                                title: "Звуки, тактильные сигналы"),
                              CellModel(
                                type: .basicCell,
                                image: UIImage(systemName: "moon.fill")?.withTintColor(.purple, renderingMode: .alwaysOriginal) ?? .add,
                                title: "Не беспокоить"),
                              CellModel(
                                type: .basicCell,
                                image: UIImage(systemName: "hourglass")?.withTintColor(.purple, renderingMode: .alwaysOriginal) ?? .add,
                                title: "Экранное время")],
                 "Section2": [CellModel(
                                type: .basicCell,
                                image: UIImage(systemName: "gear")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal) ?? .add,
                                title: "Основные"),
                              CellModel(
                                type: .basicCell,
                                image: UIImage(systemName: "switch.2")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal) ?? .add,
                                title: "Пункт управления"),
                              CellModel(
                                type: .basicCell,
                                image: UIImage(systemName: "textformat.size")?.withTintColor(.blue, renderingMode: .alwaysOriginal) ?? .add,
                                title: "Экран и яркость"),
                              CellModel(
                                type: .basicCell,
                                image: UIImage(systemName: "switch.2")?.withTintColor(.blue, renderingMode: .alwaysOriginal) ?? .add,
                                title: "Экран «Домой»"),
                              CellModel(
                                type: .basicCell,
                                image: UIImage(systemName: "person.crop.square.fill")?.withTintColor(.blue, renderingMode: .alwaysOriginal) ?? .add,
                                title: "Универсальный доступ"),
                              CellModel(
                                type: .basicCell,
                                image: UIImage(named: "wallpers") ?? .add,
                                title: "Обои"),
                              CellModel(
                                type: .basicCell,
                                image: UIImage(named: "siri") ?? .add,
                                title: "Siri и Поиск"),
                              CellModel(
                                type: .basicCell,
                                image: UIImage(systemName: "faceid")?.withTintColor(.green, renderingMode: .alwaysOriginal) ?? .add,
                                title: "Face ID и код-пароль"),
                              CellModel(
                                type: .basicCell,
                                image: UIImage(named: "sos") ?? .add,
                                title: "Экстренный вызов - SOS"),
                              CellModel(
                                type: .basicCell,
                                image: UIImage(systemName: "sun.min.fill") ?? .add,
                                title: "Уведомление о контакте")]
    ]
    
    // MARK: - Views
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(BasicCell.self, forCellReuseIdentifier: "BasicCell")
        tableView.register(CellTableSwitch.self, forCellReuseIdentifier: "CellTableSwitch")
        tableView.register(CellTableRightLabel.self, forCellReuseIdentifier: "CellTableRightLabel")
        
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHierarchy()
        setupLayout()
        navigationItem.title = "Настройки"
    }
    
    // MARK:  - Settings
    
    private func setupHierarchy(){
        view.addSubview(tableView)
    }
    
    func setupLayout() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    // Количество секций
    
    func numberOfSections(in tableView: UITableView) -> Int {
        data.keys.count
    }
    
    // Количество ячеек в секции
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data["Section\(section)"]?.count ?? 0
    }
    
    // Получение объекта ячейки
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard  let data = data["Section\(indexPath.section)"]?[indexPath.row] else { return UITableViewCell() }
        
        switch data.type {
        case .basicCell:
            return setupBasicCell(for: indexPath, with: data)
        case .cellTableSwitch:
            return setupCellTableSwitch(for: indexPath, with: data)
        case .cellTableRightLabel:
            return setupCellTableRightLabel(for: indexPath, with: data)
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("Нажата ячейка \(data["Section\(indexPath.section)"]?[indexPath.row].title ?? "Отсутствует значение")")
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // Функция настройки ячейки
    
    private  func setupBasicCell(for indexPath: IndexPath, with data: CellModel) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath) as? BasicCell
        else { return UITableViewCell() }
        
        cell.titleLabel.text = data.title
        cell.iconImage.image = data.image
        
        return cell
    }
    
    // Функция настройки ячейки
    
    private  func setupCellTableSwitch(for indexPath: IndexPath, with data: CellModel) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellTableSwitch", for: indexPath) as? CellTableSwitch
        else { return UITableViewCell() }
        
        cell.titleLabel.text = data.title
        cell.iconImage.image = data.image
        cell.accessoryView = cell.buttonSwitch
        
        return cell
    }
    
    // Функция настройки ячейки
    
    private  func setupCellTableRightLabel(for indexPath: IndexPath, with data: CellModel) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellTableRightLabel", for: indexPath) as? CellTableRightLabel
        else { return UITableViewCell() }
        
        cell.titleLabel.text = data.title
        cell.iconImage.image = data.image
        cell.rightLabel.text = data.rightLabel
        
        return cell
    }
}
