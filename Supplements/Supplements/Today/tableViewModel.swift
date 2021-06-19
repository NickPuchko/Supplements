//
//  tableViewModel.swift
//  Supplements
//
//  Created by Максим Сурков on 19.06.2021.
//

import Foundation
import UIKit
struct PillsTableViewModel {
    let sectionModels: [PillsSectionModel]?
}
struct PillsSectionModel {
    let currentDate: String?
    let date: String?
    let cells: [PillsCellModel]?
}
struct PillsCellModel {
    let image: UIImage?
    let nameOfPill: String?
    let numberOfPills: String?
}
