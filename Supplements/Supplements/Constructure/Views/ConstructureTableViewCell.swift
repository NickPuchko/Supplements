//
//  ConstructureTableViewCell.swift
//  Supplements
//
//  Created by Максим Сурков on 19.06.2021.
//

import Foundation
import UIKit
class ConstructureTableViewCell: UITableViewCell {
    
    
    var logoPillImageView = UIImageView()
    var vitaminNameLabel = UILabel()
    var pillNameLabel = UILabel()
    var priceLabel = UILabel()
    var percentageLabel = UILabel()
    var addButton = UIButton()
    var analogsButton = UIButton()
    var descriptionLabel = UILabel()
    weak var addDelegate: ConstructureViewController!
    weak var analogDelegate: ConstructureViewController!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
		let padding = CGFloat(30)

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding))
    }

	
    private func configureUI() {

		clipsToBounds = true
		layer.cornerRadius = 25
		layer.borderWidth = 1.0
		layer.borderColor = CGColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1)
		selectionStyle = .none
        addSubview(logoPillImageView)
        
        logoPillImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoPillImageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 39),
            logoPillImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            logoPillImageView.widthAnchor.constraint(equalToConstant: 56),
            logoPillImageView.heightAnchor.constraint(equalTo: logoPillImageView.widthAnchor)
        ])
        
        self.addSubview(vitaminNameLabel)
        vitaminNameLabel.translatesAutoresizingMaskIntoConstraints = false
        vitaminNameLabel.sizeToFit()
        vitaminNameLabel.font = UIFont(name: "HelveticaNeue", size: 10)
        NSLayoutConstraint.activate([
            vitaminNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            vitaminNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 13),
            
        ])
        self.addSubview(priceLabel)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.numberOfLines = 3
        descriptionLabel.textAlignment = .left
        descriptionLabel.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: logoPillImageView.trailingAnchor, constant: 10),
            descriptionLabel.topAnchor.constraint(equalTo: logoPillImageView.topAnchor),
            descriptionLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width - logoPillImageView.frame.width - 15),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2)
        ])
        
        addSubview(percentageLabel)
        percentageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            percentageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            percentageLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 13),
        ])
        
        self.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.backgroundColor = UIColor(red: 174/255, green: 232/255, blue: 128/255, alpha: 1)
        addButton.setTitle("Добавить", for: .normal)
        addButton.titleLabel?.font =  UIFont(name: "HelveticaNeue-Bold", size: 10)
        addButton.layer.cornerRadius = 3
        NSLayoutConstraint.activate([
            addButton.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            addButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 7),
            addButton.heightAnchor.constraint(equalToConstant: 20),
            addButton.widthAnchor.constraint(equalToConstant: 66)
        ])
        
        self.addSubview(analogsButton)
        analogsButton.translatesAutoresizingMaskIntoConstraints = false
        analogsButton.backgroundColor = UIColor(red: 222/255, green: 234/255, blue: 213/255, alpha: 1)
        analogsButton.titleLabel?.font =  UIFont(name: "HelveticaNeue-Bold", size: 10)
        analogsButton.setTitle("Аналоги", for: .normal)
        analogsButton.layer.cornerRadius = 3
        NSLayoutConstraint.activate([
            analogsButton.leadingAnchor.constraint(equalTo: addButton.trailingAnchor, constant: 12),
            analogsButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 7),
            analogsButton.heightAnchor.constraint(equalToConstant: 20),
            analogsButton.widthAnchor.constraint(equalToConstant: 66)
        ])
        NSLayoutConstraint.activate([
            priceLabel.leadingAnchor.constraint(equalTo: analogsButton.trailingAnchor, constant: 12),
            priceLabel.topAnchor.constraint(equalTo: analogsButton.topAnchor)
        ])
        
    }
    @objc func addButtonClick() {
        addDelegate.addPrice(cell: self)
    }
    @objc func analogButtonClick() {
        analogDelegate.analogShow(cell: self)
    }
    override func prepareForReuse() {
            super.prepareForReuse()
            self.accessoryType = .none
        }
}
