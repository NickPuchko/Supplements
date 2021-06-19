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

	var stackOptions = StackTransformViewOptions(
		scaleFactor: 0.12,
		minScale: 0.00,
		maxScale: 1.00,
		maxStackSize: 4,
		spacingFactor: 0.03,
		maxSpacing: nil,
		alphaFactor: 0.20,
		bottomStackAlphaSpeedFactor: 10.00,
		topStackAlphaSpeedFactor: 0.10,
		perspectiveRatio: 0.00,
		shadowEnabled: true,
		shadowColor: .black,
		shadowOpacity: 0.42,
		shadowOffset: .init(width: 0.28, height: 0.00),
		shadowRadius: 10.00,
		stackRotateAngel: 0.00,
		popAngle: 0.31,
		popOffsetRatio: .init(width: -1.45, height: 0.30),
		stackPosition: .init(x: 0.00, y: -1.00),
		reverse: false,
		blurEffectEnabled: false,
		maxBlurEffectRadius: 0.00,
		blurEffectStyle: .light
	)

	// The card view that we apply transforms on
	var card: UIView!
	private lazy var indexLabel = UILabel()
	private lazy var headerLabel = UILabel()

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
		headerLabel.font = Fonts.HelveticaNeue
		headerLabel.textColor = .black
		indexLabel.font = Fonts.HelveticaNeue
		indexLabel.textColor = .black
		indexLabel.numberOfLines = 2
		let cardFrame = CGRect(
			x: safeAreaLayoutGuide.layoutFrame.minX + 20,
			y: safeAreaLayoutGuide.layoutFrame.minY + 40,
		   width: safeAreaLayoutGuide.layoutFrame.maxX - 40,
		   height: safeAreaLayoutGuide.layoutFrame.maxY - 100
		)
		card = UIView(frame: cardFrame)
		card.backgroundColor = .white
		card.layer.cornerRadius = 16
		contentView.addSubview(card)
		cardView.addSubview(indexLabel)

		indexLabel.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(10)
			make.right.equalToSuperview().offset(-10)
		}

		cardView.addSubview(headerLabel)
		headerLabel.snp.makeConstraints { make in
			make.top.left.equalToSuperview().offset(10)
			make.right.greaterThanOrEqualTo(indexLabel).offset(10)
		}

		cardView.addSubview(questionsViewController.collectionView)
		questionsViewController.collectionView.snp.makeConstraints { make in
			make.top.equalTo(indexLabel.snp.bottom).offset(20)
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
		indexLabel.text = (page.index + 1).description
		headerLabel.text = header
		questionsViewController.questions = [String](page.questions.keys)
		questionsViewController.answers = [[String]](page.questions.values)
		questionsViewController.collectionView.reloadData()
	}
}
