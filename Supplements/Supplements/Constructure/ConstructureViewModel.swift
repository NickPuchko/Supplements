//
//  ConstructureViewModel.swift
//  Supplements
//
//  Created by Максим Сурков on 19.06.2021.
//

import Foundation
class ConstructureModel {
    weak var viewController: ConstructureViewController!
    
    init(_ viewController: ConstructureViewController) {
        self.viewController = viewController
    }
    
}
