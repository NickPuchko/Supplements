//
//  ContentView.swift
//  Supplements
//
//  Created by Максим Сурков on 19.06.2021.
//

import Foundation
import Foundation
import UIKit
import SnapKit
class ContentView: UIView {

	weak var viewController: FormViewController!
    
     let birthDateLabel = UILabel()
     let birthDateTextField = CustomTextField()
     let genderLabel = UILabel()
    lazy var sex = UISegmentedControl(items: sexList)
    var sexList: [String] = Sex.allCases.map{ $0.rawValue }
     let heightLabel = UILabel()
     let heightTextField = CustomTextField()
     let weightLabel = UILabel()
     let weightTextField = CustomTextField()
    
     let cityLabel = UILabel()
     let cityTextField = CustomTextField()
     let buttonOnNext = UIButton()
     let datePicker = UIDatePicker()
     lazy var iherbImageView = UIImageView(image: UIImage(named: "companyLogo.png"))
     let descriptionLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setUpBirthDateSection()
        setUpGenderSection()
        setUpHeightSection()
        setUpWeightSection()
        setUpCitySection()
        configureButton()
        addSubview(iherbImageView)
        backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        iherbImageView.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        
        iherbImageView.snp.makeConstraints { make in
                    make.top.equalTo(safeAreaLayoutGuide)
                    make.centerX.equalToSuperview()
        }
    }
    private func configure() {
        birthDateLabel.translatesAutoresizingMaskIntoConstraints = false
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        sex.translatesAutoresizingMaskIntoConstraints = false
        heightLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        buttonOnNext.translatesAutoresizingMaskIntoConstraints = false
        weightLabel.translatesAutoresizingMaskIntoConstraints = false
        
    }
    private func setUpBirthDateSection() {
        addSubview(birthDateLabel)
        birthDateLabel.text = "Дата Рождения"
        NSLayoutConstraint.activate([
            birthDateLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 60),
            birthDateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 17)
        ])
        addSubview(birthDateTextField)
        NSLayoutConstraint.activate([
            birthDateTextField.topAnchor.constraint(equalTo: birthDateLabel.bottomAnchor, constant: 8),
            birthDateTextField.leadingAnchor.constraint(equalTo: birthDateLabel.leadingAnchor),
            birthDateTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -17),
            birthDateTextField.heightAnchor.constraint(equalToConstant: 48)
        ])
    
        addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.addTarget(self, action: #selector(dueDateChanged(sender:)), for: UIControl.Event.valueChanged)
        datePicker.frame.size = datePicker.sizeThatFits(CGSize.zero)
        datePicker.setValue(UIColor.green, forKeyPath: "textColor")
        NSLayoutConstraint.activate([
            datePicker.centerYAnchor.constraint(equalTo: birthDateTextField.centerYAnchor),
            datePicker.trailingAnchor.constraint(equalTo: birthDateTextField.trailingAnchor, constant: -15),
            
        ])
        birthDateTextField.isEnabled = false
    }
    @objc func dueDateChanged(sender:UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        birthDateTextField.text = dateFormatter.string(from: sender.date)
    }
    
    private func setUpGenderSection() {
        addSubview(genderLabel)
        genderLabel.text = "Пол"
        NSLayoutConstraint.activate([
            genderLabel.topAnchor.constraint(equalTo: birthDateTextField.bottomAnchor ,constant: 21),
            genderLabel.leadingAnchor.constraint(equalTo: birthDateTextField.leadingAnchor)
        ])
        addSubview(sex)
        sex.layer.cornerRadius = 4
        sex.layer.borderWidth = 1.0
        sex.layer.borderColor = CGColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1)
        sex.selectedSegmentIndex = 0
        NSLayoutConstraint.activate([
            sex.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 8),
            sex.leadingAnchor.constraint(equalTo: genderLabel.leadingAnchor),
            sex.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -17),
            sex.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    private func setUpHeightSection() {
        addSubview(heightLabel)
        heightLabel.text = "Рост"
        NSLayoutConstraint.activate([
            heightLabel.topAnchor.constraint(equalTo: sex.bottomAnchor ,constant: 21),
            heightLabel.leadingAnchor.constraint(equalTo: sex.leadingAnchor)
        ])
        addSubview(heightTextField)
        NSLayoutConstraint.activate([
            heightTextField.topAnchor.constraint(equalTo: heightLabel.bottomAnchor, constant: 8),
            heightTextField.leadingAnchor.constraint(equalTo: heightLabel.leadingAnchor),
            heightTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -17),
            heightTextField.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    private func setUpWeightSection() {
        addSubview(weightLabel)
        weightLabel.text = "Вес"
        NSLayoutConstraint.activate([
            weightLabel.topAnchor.constraint(equalTo: heightTextField.bottomAnchor ,constant: 21),
            weightLabel.leadingAnchor.constraint(equalTo: heightTextField.leadingAnchor)
        ])
        addSubview(weightTextField)
        NSLayoutConstraint.activate([
            weightTextField.topAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: 8),
            weightTextField.leadingAnchor.constraint(equalTo: weightLabel.leadingAnchor),
            weightTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -17),
            weightTextField.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    private func setUpCitySection() {
        addSubview(cityLabel)
        cityLabel.text = "Город"
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: weightTextField.bottomAnchor ,constant: 21),
            cityLabel.leadingAnchor.constraint(equalTo: weightTextField.leadingAnchor)
        ])
        addSubview(cityTextField)
        NSLayoutConstraint.activate([
            cityTextField.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 8),
            cityTextField.leadingAnchor.constraint(equalTo: cityLabel.leadingAnchor),
            cityTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -17),
            cityTextField.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    private func configureButton() {
		buttonOnNext.addTarget(viewController, action: #selector(viewController.showSymptomsViewController), for: .touchUpInside)
        addSubview(buttonOnNext)
        buttonOnNext.isEnabled = false
        buttonOnNext.setTitle("Продолжить", for: .normal)
        buttonOnNext.backgroundColor = UIColor(red: 221/255, green: 225/255, blue: 217/255, alpha: 1)
        buttonOnNext.layer.cornerRadius = 4
        [birthDateTextField, heightTextField, weightTextField, cityTextField].forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged) })
        NSLayoutConstraint.activate([
            buttonOnNext.topAnchor.constraint(equalTo: cityTextField.bottomAnchor, constant: 21),
            buttonOnNext.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 17),
            buttonOnNext.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -17),
            buttonOnNext.heightAnchor.constraint(equalToConstant: 48)
        ])
    }


    @objc func editingChanged(_ textField: UITextField) {
        if (birthDateLabel.text != "" && heightTextField.text != "" && weightTextField.text != "" && cityTextField.text != "") {
            buttonOnNext.backgroundColor = UIColor(red: 118/255, green: 185/255, blue: 46/255, alpha: 1)
            buttonOnNext.isEnabled = true
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
