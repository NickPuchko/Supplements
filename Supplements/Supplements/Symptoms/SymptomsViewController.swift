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
    
	private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: CollectionViewPagingLayout())
	private lazy var progressBar = LinearProgressView()

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		setupCollectionView()
	}

	private func setupProgressbar() {
		progressBar.barColor = .systemGreen
		progressBar.isCornersRounded = true
		progressBar.setProgress(0, animated: false)
	}

	private func setupCollectionView() {
		collectionView.backgroundColor = .clear
		collectionView.isPagingEnabled = true
		collectionView.register(
			QuestionCell.self,
			forCellWithReuseIdentifier: "QuestionCell"
		)

		collectionView.dataSource = self

		view.addSubview(collectionView)
		collectionView.snp.makeConstraints { make in
			make.left.equalToSuperview()
			make.right.equalToSuperview()
			make.top.equalTo(view.safeAreaLayoutGuide).offset(80)
			make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-80)
		}
	}

	func collectionView(
		_ collectionView: UICollectionView,
		numberOfItemsInSection section: Int
	) -> Int {
		10
	}

	func collectionView(
		_ collectionView: UICollectionView,
		cellForItemAt indexPath: IndexPath
	) -> UICollectionViewCell {
		collectionView.dequeueReusableCell(
			withReuseIdentifier: "QuestionCell",
			for: indexPath
		)
	}

}

extension SymptomsViewController: UICollectionViewDataSource {
	func numberOfSections(in collectionView: UICollectionView) -> Int { 1 }
	
}

extension SymptomsViewController: UICollectionViewDelegate {
	didse
}
