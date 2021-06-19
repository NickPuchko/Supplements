//
//  SymptomsModel.swift
//  Supplements
//
//  Created by Nikolai Puchko on 18.06.2021.
//
//

import Foundation
import UIKit

class SymptomsModel {
	weak var viewController: SymptomsViewController!
	private lazy var networkSerivce = PagesNetworkService()
	var rowData: RowData!

	var pages: [Page] = []
    
	init(_ viewController: SymptomsViewController) {
		self.viewController = viewController
    }

	func loadPages() {
		networkSerivce.getPages { result in
			switch result {
			case .failure(let error):
				print(error)
			case .success(let loadedPages):
				self.pages = loadedPages
				self.viewController.refresh()
			}
		}
	}

	func sendRowData() {
		networkSerivce.sendRowData(rowData: rowData) { result in
			switch result {
			case .failure(let error):
				print(error)
			case .success(let diagnoses):
				print(diagnoses)
			}
		}
	}

}

struct Page: Codable {
	let index: Int
	let header: [Element]
	let questions: [String: [String]]
}

enum Element: String, Codable {
	case vitamin_a = "Витамин А",
		 vitamin_b2 = "Витамин B2",
		 vitamin_b6 = "Витамин B6",
		 vitamin_b12 = "Витамин B12",
		 vitamin_c = "Витамин C",
		 vitamin_d3 = "Витамин D3",
		 vitamin_e = "Витамин E",
		 vitamin_k = "Витамин K",
		 magnesium = "Магний",
		 zinc = "Цинк",
		 calcium = "Кальций",
		 iron = "Железо",
		 selenium = "Селен",
		 iodine = "Йод",
		 potassium = "Калий",
		 chromium = "Хром",
		 multimineral = "Мультиминеральные",
		 trace = "Остаточные минералы",
		 boron = "Бор",
		 vanadyl = "Ванадий",
		 lithium = "Литий",
		 manganese = "Марганец",
		 copper = "Медь",
		 molybdenum = "Молибден",
		 silver = "Серебро",
		 strontium = "Стронций",
		 choline = "Холин"

	init(_ element: String) {
		switch element {
		case "vitamin_a": self = .vitamin_a
		case "vitamin_b2": self = .vitamin_b2
		case "vitamin_b6": self = .vitamin_b6
		case "vitamin_b12": self = .vitamin_b12
		case "vitamin_c": self = .vitamin_c
		case "vitamin_d3": self = .vitamin_d3
		case "vitamin_e": self = .vitamin_e
		case "vitamin_k": self = .vitamin_k
		case "magnesium": self = .magnesium
		case "zinc": self = .zinc
		case "calcium": self = .calcium
		case "iron": self = .iron
		case "selenium": self = .selenium
		case "iodine": self = .iodine
		case "potassium": self = .potassium
		case "chromium": self = .chromium
		case "multimineral": self = .multimineral
		case "trace": self = .trace
		case "boron": self = .boron
		case "vanadyl": self = .vanadyl
		case "lithium": self = .lithium
		case "manganese": self = .manganese
		case "molybdenum": self = .molybdenum
		case "silver": self = .silver
		case "strontium": self = .strontium
		case "choline": self = .choline
		default: self = .vitamin_c
		}
	}
}
