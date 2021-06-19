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
    
	private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
	private lazy var progressBar = LinearProgressView()
	private lazy var layout = CollectionViewPagingLayout()


	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		setupProgressbar()
		setupCollectionView()
		layout.delegate = self
		model.loadPages()
//		navigationController?.isNavigationBarHidden = true
//		title = "Жалобы"
	}

	func refresh() {
		collectionView.reloadData()
		progressBar.maximumValue = Float(model.pages.count)
		progressBar.setProgress(Float(layout.currentPage + 1), animated: true)
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
			make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-40)
			make.centerX.equalToSuperview()
			make.height.equalTo(30)
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
			make.top.equalTo(view.safeAreaLayoutGuide)
			make.bottom.equalTo(progressBar.snp.top).offset(-20)
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
	}
}
