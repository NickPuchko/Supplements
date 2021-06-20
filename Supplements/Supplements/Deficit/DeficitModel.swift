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
	var deficits: [Deficit] = [
		.init(name: .calcium, risk: 0.75, good: nil),
		.init(name: .copper, risk: 0.3, good: nil)
	]
    
	init(_ viewController: DeficitViewController) {
		self.viewController = viewController
    }

}

struct Suggestion: Codable {
	var medicines: [Medicine]
}

struct Medicine: Codable {
	var element: Element
	var ref: String // URL
	var imageRef: String // image URL
	var price: Double
}

struct Deficit: Codable {
	var name: Element
	var risk: Float
	var good: Good?

	var advice: Advice {
		switch risk {
		case 0..<0.3:
			return .fine
		case 0.3..<0.6:
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
