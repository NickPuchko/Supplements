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
    private let buttonOnNext = UIButton()
    private let scrollView = UIScrollView()
    private let contentView = ContentView()
    
	override func viewDidLoad() {
		super.viewDidLoad()
        configureUI()
        scrollView.isScrollEnabled = false
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
	}
    @objc func keyboardWillChange(notification: Notification) {
        // вроде работает преемлемо
        scrollView.isScrollEnabled = true
        
        
    }
    private func configureUI() {
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
        scrollView.isScrollEnabled = true
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
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
    private func setUpHatView() {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        
       
        view.backgroundColor = .white
    
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
        scrollView.isScrollEnabled = false
        scrollView.scrollToTop(animated: true)
    }
}
extension UIScrollView {

    // Bonus: Scroll to top
    func scrollToTop(animated: Bool) {
        let topOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(topOffset, animated: animated)
    }
}
