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
	private lazy var imageView = UIImageView(image: UIImage(named: "background2"))
	private lazy var tableView = UITableView()
	private lazy var findCourseButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .white
		view.addSubview(imageView)
		view.addSubview(tableView)
		view.addSubview(findCourseButton)
		setupTableView()
		findCourseButton.addTarget(self, action: #selector(handleFindCourseTap), for: .touchUpInside)
		findCourseButton.setTitle("Подобрать курс", for: .normal)
		findCourseButton.backgroundColor = UIColor(red: 116/255, green: 170/255, blue: 74/255, alpha: 1)
		findCourseButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
		findCourseButton.layer.cornerRadius = 30
		findCourseButton.clipsToBounds = true
		findCourseButton.snp.makeConstraints { make in
			make.left.equalToSuperview().offset(50)
			make.right.equalToSuperview().offset(-50)
			make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
			make.height.equalTo(60)
		}
    }

	private func setupTableView() {
		tableView.register(DeficitTableViewCell.self, forCellReuseIdentifier: "DeficitTableViewCell")
		tableView.snp.makeConstraints { make in
			make.bottom.equalTo(view.safeAreaInsets)
			make.left.equalToSuperview().offset(10)
			make.right.equalToSuperview().offset(-10)
			make.top.equalToSuperview().offset(100)
		}
		tableView.dataSource = self
		tableView.allowsSelection = false
		tableView.separatorStyle = .singleLine
		tableView.showsVerticalScrollIndicator = false
		tableView.backgroundColor = .clear
	}

	@objc func handleFindCourseTap() {
		dismiss(animated: true, completion: nil)
	}

	func setupDeficits(_ deficits: [Deficit]) {
//		model.deficits = deficits
		model.deficits = [
			.init(name: .magnesium, risk: 0.2, good: nil),
			.init(name: .vitamin_b12, risk: 0.7, good: nil)
		]
	}

}


extension DeficitViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 1 }

	func numberOfSections(in tableView: UITableView) -> Int {
		model.deficits.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "DeficitTableViewCell", for: indexPath) as? DeficitTableViewCell else {
			return UITableViewCell()
		}
		cell.configure(model.deficits[indexPath.section])
		return cell
	}

	// Set the spacing between sections
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 10
	}

	// Make the background color show through
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let headerView = UIView()
		headerView.backgroundColor = UIColor.clear
		return headerView
	}
}
