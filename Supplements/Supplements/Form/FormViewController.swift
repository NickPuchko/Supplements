//
//  FormViewController.swift
//  Supplements
//
//  Created by Nikolai Puchko on 18.06.2021.
//
//

import Foundation
import UIKit
import SnapKit
import GoogleSignIn
enum Sex: String, Codable, CaseIterable {
    case male = "Мужчина"
    case female = "Женщина"
}

class FormViewController: UIViewController {
    private lazy var model = FormModel(self)
    private let hatView = UIView()
    private let logoCompany = UIImageView(image: UIImage(named: "companyLogo.png"))
    private let descriptionLabel = UILabel()
    private let birthDateLabel = UILabel()
    private let birthDateTextField = CustomTextField()
    private let datePicker = UIDatePicker()
    private let genderLabel = UILabel()
    lazy var sex = UISegmentedControl(items: sexList)
    var sexList: [String] = Sex.allCases.map{ $0.rawValue }
    private let heightLabel = UILabel()
    private let heightTextField = CustomTextField()
    private let weightLabel = UILabel()
    private let weightTextField = CustomTextField()
    
    private let cityLabel = UILabel()
    private let cityTextField = CustomTextField()
    private let buttonOnNext = UIButton()
    private let scrollView = UIScrollView()
	override func viewDidLoad() {
		super.viewDidLoad()
        configureUI()
	}
    private func configureUI() {
        hatView.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        birthDateLabel.translatesAutoresizingMaskIntoConstraints = false
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        sex.translatesAutoresizingMaskIntoConstraints = false
        heightLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        buttonOnNext.translatesAutoresizingMaskIntoConstraints = false
        weightLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        setUpHatView()
        setUpBirthDateSection()
        setUpGenderSection()
        setUpHeightSection()
        setUpWeightSection()
        setUpCitySection()
        
        view.addSubview(buttonOnNext)
        buttonOnNext.isEnabled = false
        buttonOnNext.setTitle("Продолжить", for: .normal)
        buttonOnNext.backgroundColor = UIColor(red: 118/255, green: 185/255, blue: 46/255, alpha: 1)
        buttonOnNext.layer.cornerRadius = 4
        
        NSLayoutConstraint.activate([
            buttonOnNext.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -43),
            buttonOnNext.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17),
            buttonOnNext.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17),
            buttonOnNext.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    private func setUpHatView() {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        view.addSubview(logoCompany)
        view.addSubview(descriptionLabel)
        view.backgroundColor = .white
        descriptionLabel.text = "Заполните анкету, чтобы мы провели анализ"
        descriptionLabel.numberOfLines = 2
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.textAlignment = .center
        NSLayoutConstraint.activate([
            logoCompany.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            logoCompany.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoCompany.heightAnchor.constraint(equalToConstant: 30),
            logoCompany.widthAnchor.constraint(equalToConstant: 95)
        
        ])
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: logoCompany.bottomAnchor, constant: 20),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    
    }
    
    private func setUpBirthDateSection() {
        view.addSubview(birthDateLabel)
        birthDateLabel.text = "Дата Рождения"
        NSLayoutConstraint.activate([
            birthDateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            birthDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17)
        ])
        view.addSubview(birthDateTextField)
        NSLayoutConstraint.activate([
            birthDateTextField.topAnchor.constraint(equalTo: birthDateLabel.bottomAnchor, constant: 8),
            birthDateTextField.leadingAnchor.constraint(equalTo: birthDateLabel.leadingAnchor),
            birthDateTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17),
            birthDateTextField.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    private func setUpGenderSection() {
        view.addSubview(genderLabel)
        genderLabel.text = "Пол"
        NSLayoutConstraint.activate([
            genderLabel.topAnchor.constraint(equalTo: birthDateTextField.bottomAnchor ,constant: 21),
            genderLabel.leadingAnchor.constraint(equalTo: birthDateTextField.leadingAnchor)
        ])
        view.addSubview(sex)
        sex.layer.cornerRadius = 4
        sex.layer.borderWidth = 1.0
        sex.layer.borderColor = CGColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1)
        NSLayoutConstraint.activate([
            sex.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 8),
            sex.leadingAnchor.constraint(equalTo: genderLabel.leadingAnchor),
            sex.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17),
            sex.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    private func setUpHeightSection() {
        view.addSubview(heightLabel)
        heightLabel.text = "Рост"
        NSLayoutConstraint.activate([
            heightLabel.topAnchor.constraint(equalTo: sex.bottomAnchor ,constant: 21),
            heightLabel.leadingAnchor.constraint(equalTo: sex.leadingAnchor)
        ])
        view.addSubview(heightTextField)
        NSLayoutConstraint.activate([
            heightTextField.topAnchor.constraint(equalTo: heightLabel.bottomAnchor, constant: 8),
            heightTextField.leadingAnchor.constraint(equalTo: heightLabel.leadingAnchor),
            heightTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17),
            heightTextField.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    private func setUpWeightSection() {
        view.addSubview(weightLabel)
        weightLabel.text = "Вес"
        NSLayoutConstraint.activate([
            weightLabel.topAnchor.constraint(equalTo: heightTextField.bottomAnchor ,constant: 21),
            weightLabel.leadingAnchor.constraint(equalTo: heightTextField.leadingAnchor)
        ])
        view.addSubview(weightTextField)
        NSLayoutConstraint.activate([
            weightTextField.topAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: 8),
            weightTextField.leadingAnchor.constraint(equalTo: weightLabel.leadingAnchor),
            weightTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17),
            weightTextField.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    private func setUpCitySection() {
        view.addSubview(cityLabel)
        cityLabel.text = "Город"
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: weightTextField.bottomAnchor ,constant: 21),
            cityLabel.leadingAnchor.constraint(equalTo: weightTextField.leadingAnchor)
        ])
        view.addSubview(cityTextField)
        NSLayoutConstraint.activate([
            cityTextField.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 8),
            cityTextField.leadingAnchor.constraint(equalTo: cityLabel.leadingAnchor),
            cityTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17),
            cityTextField.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    


}
