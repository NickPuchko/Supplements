//
//  PillsHeaderVIew.swift
//  Supplements
//
//  Created by Максим Сурков on 19.06.2021.
//
import Foundation
import UIKit


class  PillsHeaderView: UITableViewHeaderFooterView {
    var dateLabel = UILabel()
    var weekLabel = UILabel()
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(dateLabel)
        contentView.addSubview(weekLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        dateLabel.sizeToFit()
        weekLabel.sizeToFit()
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        weekLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        weekLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 28)
        weekLabel.textColor = .black
        dateLabel.font = UIFont(name: "HelveticaNeue", size: 21)
        dateLabel.textColor = UIColor(red: 161/255, green: 178/255, blue: 161/255, alpha: 1)
        NSLayoutConstraint.activate([
            weekLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            weekLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        
        ])
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: weekLabel.bottomAnchor, constant: 6),
            dateLabel.leadingAnchor.constraint(equalTo: weekLabel.leadingAnchor)
        
        ])
    }
    //    override init(frame: CGRect) {
//        <#code#>
//    }
    
    
}
