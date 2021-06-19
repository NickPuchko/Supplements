//
//  BlogModel.swift
//  Supplements
//
//  Created by Максим Сурков on 19.06.2021.
//

import Foundation

import UIKit

class BlogModel {
    weak var viewController: BlogViewController!
    
    init(_ viewController: BlogViewController) {
        self.viewController = viewController
    }
    
}
