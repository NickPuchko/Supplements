//
//  DeficitTableViewCell.swift
//  Supplements
//
//  Created by Nikolai Puchko on 20.06.2021.
//

import UIKit
import SnapKit
import LinearProgressView

class DeficitTableViewCell: UITableViewCell {

	private lazy var mainLabel = UILabel()
	private lazy var probLabel = UILabel()
	private lazy var progress = LinearProgressView()
	private lazy var adviceLabel = UILabel()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setup() {
		layer.cornerRadius = 20
		clipsToBounds = true
		contentView.addSubview(mainLabel)
		mainLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 24)
		mainLabel.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(20)
			make.left.equalToSuperview().offset(20)
		}

		contentView.addSubview(progress)
		progress.minimumValue = 0
		progress.maximumValue = 1
		progress.setProgress(progress.minimumValue, animated: false)
		progress.isCornersRounded = true
		progress.barInset = 5
		progress.trackColor = .systemGreen
		progress.barColor = Colors.tightGray
		progress.snp.makeConstraints { make in
			make.left.equalTo(mainLabel)
			make.right.equalToSuperview().offset(-10)
			make.top.equalTo(mainLabel.snp.bottom).offset(20)
			make.height.equalTo(20)
		}

		contentView.addSubview(adviceLabel)
		adviceLabel.font = Fonts.HelveticaNeue
		adviceLabel.numberOfLines = 2
		adviceLabel.textAlignment = .center
		adviceLabel.snp.makeConstraints { make in
			make.top.equalTo(progress.snp.bottom).offset(30)
			make.left.equalTo(mainLabel)
			make.right.equalToSuperview().offset(-20)
			make.bottom.equalToSuperview().offset(-20)
		}

		contentView.addSubview(probLabel)
		probLabel.font = Fonts.HelveticaNeue
		probLabel.snp.makeConstraints { make in
			make.centerY.equalTo(mainLabel)
			make.right.equalToSuperview().offset(-20)
		}
	}

	func configure(_ deficit: Deficit) {
		mainLabel.text = deficit.name.rawValue
		adviceLabel.text = deficit.advice.rawValue
		probLabel.text = "\((deficit.risk * 100).rounded()) %"
		progress.setProgress(deficit.risk, animated: true)

		switch deficit.advice {
		case .average:
			progress.trackColor = .systemOrange
		case .fine:
			progress.trackColor = .systemYellow
		case .dangerous:
			progress.trackColor = .systemRed
		}
	}

}
