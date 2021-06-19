//
//  CustomCollectionViewCell.swift
//  Supplements
//
//  Created by Максим Сурков on 19.06.2021.
//

import Foundation
import  UIKit

class CustomCollectionViewCell: UICollectionViewCell {
     var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    let images: [UIImage] = [
        UIImage(named: "image1"),
        UIImage(named: "image2"),
        UIImage(named: "image3"),
        UIImage(named: "image4"),
        UIImage(named: "image5"),
        UIImage(named: "image6"),
        UIImage(named: "image7"),
        UIImage(named: "image8"),
        UIImage(named: "image3"),
        UIImage(named: "image9"),
        UIImage(named: "image5"),
        UIImage(named: "image6"),
        UIImage(named: "image1"),
        UIImage(named: "image2"),
        UIImage(named: "image7"),
        UIImage(named: "image8"),
        UIImage(named: "image5"),
        UIImage(named: "image6"),
        UIImage(named: "image10"),
        UIImage(named: "image2"),
        UIImage(named: "image9"),
        UIImage(named: "image4"),
        UIImage(named: "image5"),
        UIImage(named: "image10"),
    ].compactMap({ $0 })
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.textColor = .white
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(imageView)
        imageView.image = images[images.count % Int.random(in: 5..<20)]
        contentView.clipsToBounds =  true
        contentView.layer.cornerRadius = 10
        contentView.addSubview(descriptionLabel)
        descriptionLabel.text = "asdasdasdasd"
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
        ])
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
