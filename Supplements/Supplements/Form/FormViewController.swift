
import Foundation
import UIKit
import SnapKit
import GoogleSignIn

class FormViewController: UIViewController {
    private lazy var model = FormModel(self)
    private let scrollView = UIScrollView()
    private let contentView = ContentView()
    
	override func viewDidLoad() {
		super.viewDidLoad()
		contentView.viewController = self
        navigationController?.navigationBar.isHidden = true
        configureUI()
        view.backgroundColor = .white
        scrollView.isScrollEnabled = false
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
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
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func keyboardWillChange(notification: Notification) {
        scrollView.isScrollEnabled = true
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


	@objc func showSymptomsViewController() {
		var rowData = RowData(
			height: Int(contentView.heightTextField.text!) ?? 0,
			weight: Int(contentView.weightTextField.text!) ?? 0,
			city: contentView.cityTextField.text!,
			sex: contentView.sex.selectedSegmentIndex == 0 ? "male" : "female",
			birthDate: contentView.birthDateTextField.text!,
			questions: [:])
		let symptomsViewController = SymptomsViewController(rowData)
		navigationController?.pushViewController(symptomsViewController, animated: true)
	}
}
