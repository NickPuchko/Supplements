//
//  TodayViewController.swift
//  Supplements
//
//  Created by Максим Сурков on 19.06.2021.
//

import Foundation
import UIKit
import SnapKit
import CalendarHeatmap

class TodayViewController: UIViewController {
    
    
    private func readHeatmap() -> [String: Int]? {
            guard let url = Bundle.main.url(forResource: "heatmap", withExtension: "plist") else { return nil }
            return NSDictionary(contentsOf: url) as? [String: Int]
        }
    lazy var data: [String: UIColor] = {
            guard let data = readHeatmap() else { return [:] }
            return data.mapValues { (colorIndex) -> UIColor in
                switch colorIndex {
                case 0:
                    return UIColor(named: "color1")!
                case 1:
                    return UIColor(named: "color2")!
                case 2:
                    return UIColor(named: "color3")!
                case 3:
                    return UIColor(named: "color4")!
                default:
                    return UIColor(named: "color5")!
                }
            }
        }()
    private lazy var model = TodayModel(self)
    private let containerView = UIView()
    private let pillsTableView = UITableView()
    lazy var calendarHeatMap: CalendarHeatmap = {
		var config = CalendarHeatmapConfig()
		config.backgroundColor = .white
		// config item
		config.selectedItemBorderColor = .white
		config.allowItemSelection = true
		// config month header
		config.monthHeight = 30
		config.monthStrings = DateFormatter().shortMonthSymbols
		config.monthFont = UIFont.systemFont(ofSize: 18)
		config.monthColor = UIColor(red: 169/255, green: 226/255, blue: 159/255, alpha: 1)
		// config weekday label on left
		config.weekDayFont = UIFont.systemFont(ofSize: 12)
		config.weekDayWidth = 30
		config.weekDayColor = UIColor(red: 169/255, green: 226/255, blue: 159/255, alpha: 1)
		let calendar = CalendarHeatmap(config: config, startDate: Date(2021, 1, 1), endDate:  Date(2021, 6, 20))
		calendar.delegate = self
		calendar.scrollTo(date: Date(), at: .top, animated: true)
		return calendar
	}()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
		pillsTableView.allowsSelection = false
        pillsTableView.translatesAutoresizingMaskIntoConstraints = false
        pillsTableView.delegate = self
        pillsTableView.dataSource = self
        pillsTableView.rowHeight =  68.0
        pillsTableView.layer.cornerRadius = 25
        pillsTableView.register(PillsHeaderView.self, forHeaderFooterViewReuseIdentifier: "PillsHeaderView")
        pillsTableView.register(PillsCell.self, forCellReuseIdentifier: "PillsCell")
        view.addSubview(pillsTableView)
        NSLayoutConstraint.activate([
            pillsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            pillsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pillsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pillsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        
        ])
        view.addSubview(calendarHeatMap)
        calendarHeatMap.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            calendarHeatMap.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            calendarHeatMap.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            calendarHeatMap.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            calendarHeatMap.heightAnchor.constraint(equalToConstant: 200)
        
        ])
		finishLoadCalendar()
    }

}

extension TodayViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "PillsHeaderView") as? PillsHeaderView
        header?.dateLabel.text = "20 июня, воскресенье"
        header?.weekLabel.text = "Сегодня"
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
}
extension TodayViewController: UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PillsCell", for: indexPath) as! PillsCell
		cell.pillNameLabel.text = Element.allCases.randomElement()?.rawValue
        cell.doseLabel.text = "\(Int.random(in: 2..<4)) таблетки"
        var number = Int.random(in: 00..<60)
        if number < 10 {
            number += 10
        }
        cell.lableDate.text = "\(Int.random(in: 12..<21)):\(number)"
        return cell
    }
    
}
extension TodayViewController: CalendarHeatmapDelegate {

    func colorFor(dateComponents: DateComponents) -> UIColor {
        guard let year = dateComponents.year,
            let month = dateComponents.month,
            let day = dateComponents.day else { return .clear}
        let dateString = "\(year).\(month).\(day)"
        if dateString == "2021.6.20" {
            return .green
		} else {
			if dateComponents.weekday == 2 {
				return .init(red: 0, green: 1, blue: 0, alpha: 0.5)
			}
			if dateComponents.weekday == 4 {
				return .init(red: 0, green: 1, blue: 0, alpha: 0.2)
			}
		}
        return data[dateString] ?? UIColor(red: 169/255, green: 226/255, blue: 159/255, alpha: 1)
    }
    
    func finishLoadCalendar() {
        calendarHeatMap.scrollTo(date: Date(2021, 06, 20), at: .right, animated: false)
    }
}
