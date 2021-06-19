//
//  SymptomsViewController.swift
//  Supplements
//
//  Created by Nikolai Puchko on 18.06.2021.
//
//

import Foundation
import UIKit
import SnapKit
import CollectionViewPagingLayout
import LinearProgressView


class SymptomsViewController: UIViewController {
    private lazy var model = SymptomsModel(self)

	private lazy var iherbImageView = UIImageView(image: UIImage(named: "companyLogo.png")!)
	private lazy var mainLabel = UILabel()
	private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
	private lazy var progressBar = LinearProgressView()
	private lazy var finishButton = UIButton(type: .custom)
	private lazy var layout = CollectionViewPagingLayout()


	override func viewDidLoad() {
		super.viewDidLoad()
		let patternSize = CGSize(width: view.frame.width, height: 300)
		let backgroundImage = UIImage(named: "background")!.imageResize(sizeChange: patternSize)
		view.backgroundColor = UIColor(patternImage: backgroundImage)

		setupProgressbar()
		setupCollectionView()
		setupHeader()
		layout.delegate = self
		model.loadPages()

		navigationController?.isNavigationBarHidden = true
	}

	func refresh() {
		collectionView.reloadData()
		layout.setCurrentPage(0)
		progressBar.maximumValue = Float(model.pages.count)
		progressBar.setProgress(Float(layout.currentPage + 1), animated: true)
	}

	private func setupHeader() {
		mainLabel.text = "Замечали ли Вы у себя такие симптомы?"
		mainLabel.numberOfLines = 2
		mainLabel.textAlignment = .center
		mainLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
		iherbImageView.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
		view.addSubview(mainLabel)
		view.addSubview(iherbImageView)
		view.addSubview(finishButton)
		mainLabel.snp.makeConstraints { make in
			make.centerX.equalToSuperview()
			make.width.equalToSuperview().multipliedBy(0.65)
			make.top.equalTo(iherbImageView.snp.bottom).offset(30)
			make.bottom.equalTo(collectionView.snp.top).offset(-30)
		}
		iherbImageView.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
			make.centerX.equalToSuperview()
		}

		finishButton.setTitle("Перейти к прогнозам", for: .normal)
		finishButton.titleLabel?.font = Fonts.HelveticaNeue
		finishButton.layer.cornerRadius = 8
		finishButton.backgroundColor = Colors.tightGray
		finishButton.isEnabled = false

		finishButton.snp.makeConstraints { make in
			make.top.equalTo(progressBar.snp.bottom).offset(15)
			make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
			make.centerX.equalToSuperview()
			make.width.equalToSuperview().multipliedBy(0.8)
			make.height.equalTo(40)
		}


	}

	private func setupProgressbar() {
		progressBar.barColor = .white
		progressBar.trackColor = .systemGreen
		progressBar.isCornersRounded = true
		progressBar.barInset = 5
		progressBar.layer.borderWidth = 1
		progressBar.layer.borderColor = UIColor.systemGreen.cgColor
		progressBar.minimumValue = 1

		view.addSubview(progressBar)
		progressBar.snp.makeConstraints { make in
			make.centerX.equalToSuperview()
			make.height.equalTo(20)
		}
	}

	private func setupCollectionView() {
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.backgroundColor = .clear
		collectionView.isPagingEnabled = true
		layout.zPositionHandler = .layoutAttribute
		collectionView.register(
			PageCell.self,
			forCellWithReuseIdentifier: "PageCell"
		)

		collectionView.dataSource = self
		collectionView.delegate = self

		view.addSubview(collectionView)
		collectionView.snp.makeConstraints { make in
			make.left.equalToSuperview()
			make.right.equalToSuperview()
			make.width.equalTo(progressBar).dividedBy(0.75)
			make.bottom.equalTo(progressBar.snp.top)
		}
	}

	func collectionView(
		_ collectionView: UICollectionView,
		numberOfItemsInSection section: Int
	) -> Int {
		model.pages.count
	}

	func collectionView(
		_ collectionView: UICollectionView,
		cellForItemAt indexPath: IndexPath
	) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: "PageCell",
			for: indexPath
		) as? PageCell else {
			return UICollectionViewCell()
		}
		cell.configure(with: model.pages[indexPath.row])
		return cell
	}

}

extension SymptomsViewController: UICollectionViewDataSource {
	func numberOfSections(in collectionView: UICollectionView) -> Int { 1 }
	
}

extension SymptomsViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

	}
}

extension SymptomsViewController: CollectionViewPagingLayoutDelegate {
	func onCurrentPageChanged(layout: CollectionViewPagingLayout, currentPage: Int) {
		progressBar.setProgress(Float(currentPage + 1), animated: true)
		if currentPage + 1 == model.pages.count {
			finishButton.backgroundColor = UIColor(red: 118/255, green: 185/255, blue: 46/255, alpha: 1)
			finishButton.isEnabled = true
		} else {
			finishButton.backgroundColor = Colors.tightGray
			finishButton.isEnabled = false
		}
	}
}
