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
    private let logoCompany = UIImageView(image: UIImage(named: "companyLogo.png"))
    private let descriptionLabel = UILabel()
    private let buttonOnNext = UIButton()
    private let scrollView = UIScrollView()
    private let contentView = ContentView()
    
	override func viewDidLoad() {
		super.viewDidLoad()
        configureUI()
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
	}
    private func configureUI() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
        scrollView.isScrollEnabled = true
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: view.frame.height + 100),
            
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
        setUpHatView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0 {
                self.view.frame.origin.y -= (keyboardSize.height)
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        
        if view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
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
            descriptionLabel.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            descriptionLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        
        ])
        NSLayoutConstraint.activate([
            logoCompany.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -40),
            logoCompany.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoCompany.heightAnchor.constraint(equalToConstant: 30),
            logoCompany.widthAnchor.constraint(equalToConstant: 95)
        ])
    
    }
    
    
    


}
extension FormViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(FormViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
