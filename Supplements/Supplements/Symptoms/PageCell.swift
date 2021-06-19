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
class PageCell: UICollectionViewCell, StackTransformView {

	var stackOptions: StackTransformViewOptions {
		.layout(.transparent)
	}

	// The card view that we apply transforms on
	var card: UIView!
	private lazy var elementLabel = UILabel()
	private lazy var indexLabel = UILabel()

	private lazy var questionsViewController = QuestionsCollectionViewController(questions: [:])


	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setup()
	}

	func setup() {
		indexLabel.font = Fonts.SDGothicNeoBold
		indexLabel.textColor = .white
		elementLabel.font = Fonts.SDGothicNeoBold
		elementLabel.textColor = .white
		elementLabel.numberOfLines = 2
		let cardFrame = CGRect(
			x: safeAreaLayoutGuide.layoutFrame.minX + 20,
			y: safeAreaLayoutGuide.layoutFrame.minY + 20,
		   width: safeAreaLayoutGuide.layoutFrame.maxX - 40,
		   height: safeAreaLayoutGuide.layoutFrame.maxY - 100
		)
		card = UIView(frame: cardFrame)
		card.backgroundColor = .systemGreen
		card.layer.cornerRadius = 16
		contentView.addSubview(card)
		cardView.addSubview(elementLabel)

		elementLabel.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(10)
			make.right.equalToSuperview().offset(-10)
		}

		cardView.addSubview(indexLabel)
		indexLabel.snp.makeConstraints { make in
			make.top.left.equalToSuperview().offset(10)
			make.right.greaterThanOrEqualTo(elementLabel).offset(10)
		}

		cardView.addSubview(questionsViewController.collectionView)
		questionsViewController.collectionView.snp.makeConstraints { make in
			make.top.equalTo(elementLabel.snp.bottom).offset(20)
			make.left.equalTo(cardView).offset(20)
			make.right.equalTo(cardView).offset(-20)
			make.bottom.equalTo(cardView).offset(-20)
		}
	}

	func configure(with page: Page) {
		var header = ""
		for (index, element) in page.header.enumerated() {
			if index + 1 == page.header.count {
				header.append(element.rawValue)
			} else {
				header.append("\(element.rawValue), ")
			}
		}
		elementLabel.text = header
		indexLabel.text = (page.index + 1).description
		questionsViewController.questions = page.questions
		questionsViewController.collectionView.reloadData()
	}
}
