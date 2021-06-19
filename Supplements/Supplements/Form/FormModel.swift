//
//  FormModel.swift
//  Supplements
//
//  Created by Nikolai Puchko on 18.06.2021.
//
//

import Foundation
import UIKit

class FormModel {
	weak var viewController: FormViewController!
    
	init(_ viewController: FormViewController) {
		self.viewController = viewController
    }
    
}

struct RowData: Codable {
	let height: Int
	let weight: Int
	let city: String
	let sex: String
	let birthDate: String
	var questions: [String: String] = [:]
}
