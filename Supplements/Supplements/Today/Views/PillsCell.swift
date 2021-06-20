//
//  PillsCell.swift
//  Supplements
//
//  Created by Максим Сурков on 19.06.2021.
//

import Foundation
import UIKit

class PillsCell: UITableViewCell {
    
     var pillNameLabel = UILabel()
     var doseLabel = UILabel()
     var lableDate = UILabel()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.addSubview(pillNameLabel)
        self.addSubview(doseLabel)
        self.addSubview(lableDate)
        pillNameLabel.translatesAutoresizingMaskIntoConstraints = false
        doseLabel.translatesAutoresizingMaskIntoConstraints = false
        lableDate.translatesAutoresizingMaskIntoConstraints = false
        
        pillNameLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        pillNameLabel.textColor = .black
        doseLabel.font = UIFont(name: "HelveticaNeue", size: 12)
        doseLabel.textColor = UIColor(red: 161/255, green: 178/255, blue: 161/255, alpha: 1)
        lableDate.sizeToFit()
        NSLayoutConstraint.activate([
			pillNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 14),
            pillNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            pillNameLabel.heightAnchor.constraint(equalToConstant: 19),
        ])
        NSLayoutConstraint.activate([
            doseLabel.leadingAnchor.constraint(equalTo: pillNameLabel.leadingAnchor),
            doseLabel.topAnchor.constraint(equalTo: pillNameLabel.bottomAnchor, constant: 4),
            doseLabel.heightAnchor.constraint(equalToConstant: 13),
        ])
        NSLayoutConstraint.activate([
            lableDate.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            lableDate.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    override func prepareForReuse() {
            super.prepareForReuse()
            self.accessoryType = .none
        }
}



