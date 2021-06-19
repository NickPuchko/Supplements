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
			}
			self.pages = [
				Page(index: 0, header: [.vitamin_a], questions: ["Ломкость волос": ["Не указано", "0", "1", "2", "3", "4", "5"], "Сухость кожи": ["Не указано", "0", "1", "2", "3", "4", "5"], "Ухудшение зрения": ["Не указано", "0", "1", "2", "3", "4", "5"], "Появление полос на ногтях": ["Не указано", "0", "1", "2", "3", "4", "5"]]),
				Page(index: 1, header: [.vitamin_b2, .vitamin_b6], questions: ["Ухудшение аппетита": [], "Ухудшение сна": [], "Раздражительность": [], "Трещины на губах": [], "Выпадание волос": []]),
				Page(index: 2, header: [.vitamin_c], questions: ["Кровоточивость дёсен": [], "Утомляемость": [], "Частые простуды": []]),
				Page(index: 3, header: [.vitamin_d3], questions: ["Судороги": [], "Склонность к переломам": []]),
				Page(index: 4, header: [.vitamin_e], questions: ["Бледность": [], "Мышечная слабость": []])
			]
				self.viewController.refresh()


		}
	}

//	private func requestPages() {
//		let loadedPages = [
//			Page(index: 0, header: [.A], questions: ["Ломкость волос": [], "Сухость кожи": [], "Ухудшение зрения": [], "Появление полос на ногтях": []]),
//			Page(index: 1, header: [.B2, .B6], questions: ["Ухудшение аппетита": [], "Ухудшение сна": [], "Раздражительность": [], "Трещины на губах": [], "Выпадание волос": []]),
//			Page(index: 2, header: [.C], questions: ["Кровоточивость дёсен": [], "Утомляемость": [], "Частые простуды": []]),
//			Page(index: 3, header: [.D], questions: ["Судороги": [], "Склонность к переломам": []]),
//			Page(index: 4, header: [.E], questions: ["Бледность": [], "Мышечная слабость": []])
//		]
//	}
    
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
}
