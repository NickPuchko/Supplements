//
//  DeficitModel.swift
//  Supplements
//
//  Created by Nikolai Puchko on 19.06.2021.
//
//

import Foundation
import UIKit

class DeficitModel {
	weak var viewController: DeficitViewController!
	var deficits: [Deficit] = []
    
	init(_ viewController: DeficitViewController) {
		self.viewController = viewController
    }

}

struct Deficit: Codable {
	var name: Element
	var risk: Float
	var good: Good?

	var advice: Advice {
		switch risk {
		case 0..<20:
			return .fine
		case 20..<50:
			return .average
		default:
			return .dangerous
		}
	}
}

enum Advice: String, Codable {
	case fine = "Состояние в норме, но в будущем могут возникнуть проблемы."
	case average = "Желательно пройти профилактику."
	case dangerous = "Необходимо проконсультироваться со специалистом!"
}

struct Good: Codable {
	var name: String
	var price: Int
	var ref: URL?
}
