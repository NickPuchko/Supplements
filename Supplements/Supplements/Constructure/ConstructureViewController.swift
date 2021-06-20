//
//  ConstructureViewController.swift
//  Supplements
//
//  Created by Максим Сурков on 19.06.2021.
//

import Foundation
import UIKit

class ConstructureViewController: UIViewController {
    private lazy var model = ConstructureModel(self)
    private let imageView = UIImageView(image: UIImage(named: "background2"))
    private let tableView = UITableView()
    private let startCourse = UIButton()
	private let restartCourse = UIButton()
    private var priceLabel = UILabel()
    private var price = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        view.addSubview(tableView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        setUptableView()
		startCourse.addTarget(self, action: #selector(openToday), for: .touchUpInside)
        startCourse.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(startCourse)
        NSLayoutConstraint.activate([
            startCourse.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            startCourse.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startCourse.heightAnchor.constraint(equalToConstant: 62),
            startCourse.widthAnchor.constraint(equalToConstant: 319)
        ])
        startCourse.layer.cornerRadius = 34
        startCourse.backgroundColor = UIColor(red: 116/255, green: 170/255, blue: 74/255, alpha: 1)
        startCourse.setTitle("Начать курс", for: .normal)
        startCourse.titleLabel?.font =  UIFont(name: "HelveticaNeue-Bold", size: 20)

        view.addSubview(priceLabel)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.text = "\(price) р/мес"
        priceLabel.textAlignment = .center
		priceLabel.textColor = .white
		priceLabel.layer.cornerRadius = 14
		priceLabel.clipsToBounds = true
        

        priceLabel.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.4)
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            priceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            priceLabel.heightAnchor.constraint(equalToConstant: 46),
            priceLabel.widthAnchor.constraint(equalToConstant: 160)
        ])

		view.addSubview(restartCourse)
		restartCourse.addTarget(self, action: #selector(startForm), for: .touchUpInside)
		let restartImage = UIImage(systemName: "arrow.clockwise.heart")!
		restartCourse.setImage(restartImage, for: .normal)
		restartCourse.contentMode = .redraw
		restartCourse.layer.cornerRadius = 14
		restartCourse.clipsToBounds = true
		restartCourse.tintColor = .white
		restartCourse.translatesAutoresizingMaskIntoConstraints = false
		restartCourse.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.4)

		NSLayoutConstraint.activate([
			restartCourse.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
			restartCourse.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 40),
			restartCourse.widthAnchor.constraint(equalToConstant: 46),
			restartCourse.heightAnchor.constraint(equalToConstant: 46)
		])

		if price == 0 {
			startCourse.isEnabled = false
			startCourse.alpha = 0.5
		}

    }

	@objc func openToday() {
		(UIApplication.shared.delegate as! AppDelegate).tabBar.selectedIndex = 0
	}

	@objc func startForm() {
		UserDefaults.standard.setValue(false, forKey: "isUserOld")
		(UIApplication.shared.delegate as! AppDelegate).start()
	}

    private func setUptableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.backgroundColor = .clear
        tableView.layer.cornerRadius = 25
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight =  131.0
        tableView.separatorStyle = .none
		tableView.showsVerticalScrollIndicator = false
        tableView.register(ConstructureTableViewCell.self, forCellReuseIdentifier: "ConstructureTableViewCell")
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}
extension ConstructureViewController: UITableViewDelegate {
    
}
extension ConstructureViewController: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 10
	}

	// There is just one row in every section
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
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

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConstructureTableViewCell", for: indexPath) as! ConstructureTableViewCell
        cell.logoPillImageView.image = UIImage(named: "vitaminImage")
        cell.vitaminNameLabel.text = "Витамин С"
        cell.priceLabel.text = "1200"
        cell.percentageLabel.text = "80%"
        var str = "California Gold Nutrition, Gold C, витамин C, 1000 мг, 60 вегетарианских капсул asdasdasd"
        if str.count > 79 {
            str = String(str.prefix(79)) + "..."
        }
        cell.descriptionLabel.text = str
        cell.addButton.addTarget(cell, action: #selector(cell.addButtonClick), for: .touchUpInside)
        cell.addDelegate = self
        cell.analogDelegate = self
        cell.analogsButton.addTarget(cell, action: #selector(cell.analogButtonClick), for: .touchUpInside)
        return cell
    }

    func addPrice(cell: ConstructureTableViewCell) {
        if cell.addButton.currentTitle == "Добавить" {
            price += Int(cell.priceLabel.text ?? "0") ?? 0
            priceLabel.text = String("\(price) р/мес")
            cell.addButton.setTitle("Убрать", for: .normal)
            cell.addButton.backgroundColor = .red
        } else  if cell.addButton.currentTitle == "Убрать" {
            price -= Int(cell.priceLabel.text ?? "0") ?? 0
            priceLabel.text = String("\(price) р/мес")
            cell.addButton.setTitle("Добавить", for: .normal)
            cell.addButton.backgroundColor = UIColor(red: 174/255, green: 232/255, blue: 128/255, alpha: 1)
        }
		UIView.animate(withDuration: 1) {
			if self.price == 0 {
				self.startCourse.isEnabled = false
				self.startCourse.alpha = 0.5
			} else {
				self.startCourse.isEnabled = true
				self.startCourse.alpha = 1
			}
		}
        
    }
    func analogShow(cell: ConstructureTableViewCell) {
        print("nope")
    }
    
}
