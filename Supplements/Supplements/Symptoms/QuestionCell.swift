//
//  QuestionCell.swift
//  Supplements
//
//  Created by Nikolai Puchko on 19.06.2021.
//

import UIKit
import CollectionViewPagingLayout
// The cell class needs to conform to `StackTransformView` protocol
// to be able to provide the transform options
class QuestionCell: UICollectionViewCell, StackTransformView {

	var stackOptions: StackTransformViewOptions {
		.layout(.transparent)
	}

	// The card view that we apply transforms on
	var card: UIView!

	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setup()
	}

	func setup() {

		// Adjust the card view frame
		// you can use Auto-layout too
		let cardFrame = CGRect(
			x: safeAreaLayoutGuide.layoutFrame.minX + 40,
			y: safeAreaLayoutGuide.layoutFrame.minY + 40,
		   width: safeAreaLayoutGuide.layoutFrame.maxX - 80,
		   height: safeAreaLayoutGuide.layoutFrame.maxY - 160
		)
		card = UIView(frame: cardFrame)
		card.backgroundColor = .systemGreen
		card.layer.cornerRadius = 16
		contentView.addSubview(card)
	}
}
