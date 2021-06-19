//
//  QuestionCell.swift
//  Supplements
//
//  Created by Nikolai Puchko on 19.06.2021.
//

import UIKit

class QuestionCell: UICollectionViewCell {
	lazy var label = InsetLabel(inset: UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 30))
	override init(frame: CGRect) {
		super.init(frame: .zero)
		label.font = Fonts.HelveticaNeue
		label.layer.cornerRadius = 14
		label.clipsToBounds = true
		label.backgroundColor = Colors.tightGray
		label.textColor = .white
		label.layer.borderWidth = 0.5
		label.layer.borderColor = UIColor.white.cgColor

		contentView.addSubview(label)
		label.snp.makeConstraints { make in
			make.top.left.equalToSuperview()
			make.bottom.right.equalToSuperview()
		}
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
