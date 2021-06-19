//
//  TodayModel.swift
//  Supplements
//
//  Created by Максим Сурков on 19.06.2021.
//

import Foundation

import UIKit

class TodayModel {
    weak var viewController: TodayViewController!
    
    init(_ viewController: TodayViewController) {
        self.viewController = viewController
    }
    
}
