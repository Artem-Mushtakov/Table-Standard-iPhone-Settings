//
//  ViewController.swift
//  Table-Settings
//
//  Created by Артем on 23.07.2021.
//

//import UIKit
//
//class ViewController: UIViewController {
//
//    var model: CellModel?
//
//    // MARK: - Views
//
//    private lazy var tableView: UITableView = {
//        let tableView = UITableView(frame: .zero, style: .grouped)
//
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.register(BasicCellView.self, forCellReuseIdentifier: "BasicCellView")
//        tableView.register(CellTableSwitchView.self, forCellReuseIdentifier: "CellTableSwitchView")
//        tableView.register(CellTableRightLabelView.self, forCellReuseIdentifier: "CellTableRightLabelView")
//
//        return tableView
//    }()
//
//    // MARK: - Lifecycle
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        setupHierarchy()
//        setupLayout()
//        navigationItem.title = "Настройки"
//    }
//
//    // MARK:  - Settings
//
//    private func setupHierarchy(){
//        view.addSubview(tableView)
//    }
//
//    func setupLayout() {
//
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: view.topAnchor),
//            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
//        ])
//    }
//}
//
//extension ViewController: UITableViewDataSource, UITableViewDelegate {
//
//    // Количество секций
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        model?.createCellModel().keys.count ?? 0
//    }
//
//    // Количество ячеек в секции
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        model?.createCellModel()["Section\(section)"]?.count ?? 0
//    }
//
//    // Получение объекта ячейки
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard  let data = model?.createCellModel()["Section\(indexPath.section)"]?[indexPath.row].type else { return UITableViewCell() }
//
//        switch data {
//        case .basicCell:
//            return setupBasicCell(for: indexPath, with: data)
//        case .cellTableSwitch:
//            return setupCellTableSwitch(for: indexPath, with: data)
//        case .cellTableRightLabel:
//            return setupCellTableRightLabel(for: indexPath, with: data)
//        }
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        print("Нажата ячейка \(model?.createCellModel()["Section\(indexPath.section)"]?[indexPath.row].title ?? "Отсутствует значение")")
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//
//    // Функция настройки ячейки
//
//    private  func setupBasicCell(for indexPath: IndexPath, with data: CellType) -> UITableViewCell {
//
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCellView", for: indexPath) as? BasicCellView
//        else { return UITableViewCell() }
//
//        cell.titleLabel.text = model?.createCellModel()["Section\(indexPath.section)"]?[indexPath.row].title
//        cell.iconImage.image = model?.createCellModel()["Section\(indexPath.section)"]?[indexPath.row].image
//
//        return cell
//    }
//
//    // Функция настройки ячейки
//
//    private  func setupCellTableSwitch(for indexPath: IndexPath, with data: CellType) -> UITableViewCell {
//
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellTableSwitchView", for: indexPath) as? CellTableSwitchView
//        else { return UITableViewCell() }
//
//        cell.titleLabel.text = model?.createCellModel()["Section\(indexPath.section)"]?[indexPath.row].title
//        cell.iconImage.image = model?.createCellModel()["Section\(indexPath.section)"]?[indexPath.row].image
//        cell.accessoryView = cell.buttonSwitch
//
//        return cell
//    }
//
//    // Функция настройки ячейки
//
//    private  func setupCellTableRightLabel(for indexPath: IndexPath, with data: CellType) -> UITableViewCell {
//
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellTableRightLabelView", for: indexPath) as? CellTableRightLabelView
//        else { return UITableViewCell() }
//
//        cell.titleLabel.text = model?.createCellModel()["Section\(indexPath.section)"]?[indexPath.row].title
//        cell.iconImage.image = model?.createCellModel()["Section\(indexPath.section)"]?[indexPath.row].image
//        cell.rightLabel.text = model?.createCellModel()["Section\(indexPath.section)"]?[indexPath.row].rightLabel
//
//        return cell
//    }
//}

import UIKit

final class ViewController: UIViewController {
    
    var model: CellModel?
    
    /// Это вычисляемое свойство преобразует тип родительской view в OnboardingView
    /// Это делается чтобы мы в будущем могли из Controller'a обращаться к элементам View
    private var onboardingView: CellView? {
        guard isViewLoaded else { return nil }
        return view as? CellView
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Присваиваем значению View наш созданный класс OnboardingView()
        /// Можно это сделать в Main.storyboard, но я решил сделать так
        view = CellView()
        model = CellModel()
        navigationItem.title = "Настройки"
        configureView()
    }
}

// MARK: - Configurations

private extension ViewController {
    func configureView() {
        guard let model = model?.createCellModel() else { return }
        onboardingView?.configureView(with: model)
    }
}

