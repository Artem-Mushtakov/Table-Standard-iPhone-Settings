//
//  CellModel.swift
//  Table-Standard-iPhone-Settings
//
//  Created by Артем on 20.08.2021.
//

import Foundation
import UIKit

enum CellType {
    case basicCell
    case cellTableSwitch
    case cellTableRightLabel
}

struct Cell {
    let type: CellType
    var image: UIImage
    let title: String
    var rightLabel: String?
}
