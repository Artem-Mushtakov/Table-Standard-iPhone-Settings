//
//  ViewController.swift
//  Table-Settings
//
//  Created by Артем on 23.07.2021.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - Properties
    
    var model: CellModel?
    
    private var tableView: CellView? {
        guard isViewLoaded else { return nil }
        return view as? CellView
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Настройки"
        view = CellView()
        model = CellModel()
        configureView()
    }
}

    // MARK: - Configurations

private extension ViewController {
    
    func configureView() {
        
        guard let model = model?.createCellModel() else { return }
        tableView?.configureView(with: model)
    }
}

