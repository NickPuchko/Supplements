//
//  DeficitViewController.swift
//  Supplements
//
//  Created by Nikolai Puchko on 19.06.2021.
//
//

import Foundation
import UIKit
import SnapKit

class DeficitViewController: UIViewController {
    private lazy var model = DeficitModel(self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

	func setupDeficits(_ deficits: [Deficit]) {
//		model.deficits = deficits
		model.deficits = [
			.init(name: .magnesium, risk: 0.2, good: nil),
			.init(name: .vitamin_b12, risk: 0.7, good: nil)
		]
	}

}
