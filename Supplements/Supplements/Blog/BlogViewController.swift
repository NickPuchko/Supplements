//
//  BlogViewController.swift
//  Supplements
//
//  Created by Максим Сурков on 19.06.2021.
//


import Foundation
import UIKit
import SnapKit
import GoogleSignIn
//TODO: сделать фильтрацию
class BlogViewController: UIViewController {
    private lazy var model = BlogModel(self)
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: BlogViewController.createLayout()
    )
    var data = ["Ашваганда – лучшая добавка для управления стрессом", "Почему морской коллаген может стать вашим спасением",
    "Пять признаков дефицита железа", "Грибные добавки в тренде для улучшения настроения", "Четыре полезных свойства пектина", "Могут ли липосомальные витамины быть более полезными?", "Семь подарков ко Дню матери своими руками из натуральных ингредиентов"]
    var urls = ["https://ru.iherb.com/blog/ashwagandha-stress-support/1162", "https://ru.iherb.com/blog/marine-collagen-health-benefits/1287", "https://ru.iherb.com/blog/iron-deficiency/1107", "https://ru.iherb.com/blog/benefits-of-mushroom-supplements/1273", "https://ru.iherb.com/blog/5-health-benefits-of-pectin/1285",
    "https://ru.iherb.com/blog/liposomal-vitamin-health-benefits/1252", "https://ru.iherb.com/blog/homemade-natural-mothers-day-gifts/382"]
    private let headerLabel = UILabel()
    private let searchTextField = PickerTextField()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        configureUI()
        
    }
    
    private func configureUI() {
        view.addSubview(collectionView)
        view.isUserInteractionEnabled = true
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCollectionViewCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        //collectionView.frame = view.bounds
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        view.addSubview(headerLabel)
        headerLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        headerLabel.textColor = .black
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.text = "Статьи"
        NSLayoutConstraint.activate([
            headerLabel.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -17),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        view.addSubview(searchTextField)
		searchTextField.textAlignment = .center
		searchTextField.layer.cornerRadius = 12
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        //searchTextField.isEnabled = false
        searchTextField.rightView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        searchTextField.rightViewMode = .always
        searchTextField.pills = Element.allCases.map({$0.rawValue})
        searchTextField.displayNameHandler = { item in
            return item as? String ?? ""
            
        }
        searchTextField.itemSelectionHandler = { index, item in
            print(index , " ", item)
            
        }
        NSLayoutConstraint.activate([
            searchTextField.leadingAnchor.constraint(equalTo: headerLabel.trailingAnchor, constant: 30),
            //searchTextField.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor),
            searchTextField.centerYAnchor.constraint(equalTo: headerLabel.centerYAnchor),
            searchTextField.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -17),
            searchTextField.widthAnchor.constraint(equalToConstant: view.frame.width - headerLabel.frame.width - 140),
            searchTextField.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    static func createLayout() -> UICollectionViewCompositionalLayout {
        let item = NSCollectionLayoutItem(
            layoutSize:NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(2/3),
                heightDimension: .fractionalHeight(1)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
        let verticalStackItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(0.44))
            )
        let VerticalStackGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1/3),
                heightDimension: .fractionalHeight(1)),
            subitem: verticalStackItem,
            count: 2)
        VerticalStackGroup.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
        let trippleItem = NSCollectionLayoutItem(layoutSize:
            NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalWidth(1)
            )
        )
        trippleItem.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
        let trippletHorizontalGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(0.3)
            ),
            subitem: trippleItem,
            count: 3)
        let horizontalGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(0.7)),
            subitems: [
                item,
                VerticalStackGroup
            ])
        let verticalGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            ),
            subitems: [
                horizontalGroup,
                trippletHorizontalGroup
            ])
        let section = NSCollectionLayoutSection(group: verticalGroup)
        return UICollectionViewCompositionalLayout(section: section)
    }
}
extension BlogViewController: UICollectionViewDelegate, UITableViewDelegate {
//    private func collectionView(_ collectionView: UICollectionView, didSelectRowAtIndexPath indexPath: IndexPath) {
//
//        var url : NSURL?
//        url = NSURL(string: urls[indexPath.row])
//        if url != nil{
//            UIApplication.shared.openURL(url! as URL)
//            }
//    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var url : NSURL?
        url = NSURL(string: urls[indexPath.row])
        if url != nil{
            UIApplication.shared.openURL(url! as URL)
            }
    }
}
extension BlogViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return urls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
        
        if data[indexPath.row].count > 15 {
            cell.descriptionLabel.text = String(data[indexPath.row].prefix(10)) + "..."
        } else {
            cell.descriptionLabel.text = data[indexPath.row]
        }
        return cell
    }
}

