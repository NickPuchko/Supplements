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

class FormViewController: UIViewController {
    private lazy var model = FormModel(self)

	private let GIDService: GIDSignIn
	private let image: UIImage?
	
	init(_ signInDelegate: GIDSignIn, image: UIImage?) {
		GIDService = signInDelegate
		self.image = image
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private lazy var profileImageView: UIImageView = {
		let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
		imageView.image = image
		imageView.layer.cornerRadius = imageView.frame.width / 2
		imageView.layer.shadowRadius = 3
		return imageView
	}()

	private lazy var welcomeLabel: UILabel = {
		let label = UILabel()
		label.text = "You've signed successfully!"
		label.font = Fonts.SDGothicNeoLight
		label.tintColor = .white
		label.textAlignment = .center
		return label
	}()

	private lazy var signOutButton: UIButton = {
		let button = UIButton()
		button.setTitle("Sign out", for: .normal)
		button.backgroundColor = .systemBlue
		button.tintColor = .white
		button.layer.cornerRadius = 16
		button.addTarget(self, action: #selector(handleSignOutTap), for: .touchUpInside)
		return button
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .black
		view.addSubview(welcomeLabel)
		welcomeLabel.snp.makeConstraints { make in
			make.centerX.centerY.equalToSuperview()
		}

		view.addSubview(signOutButton)
		signOutButton.snp.makeConstraints { make in
			make.centerX.equalToSuperview()
			make.top.greaterThanOrEqualTo(welcomeLabel.snp.bottom).offset(40)
			make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-80)
			make.width.equalToSuperview().multipliedBy(0.8)
			make.height.equalTo(60)
		}

		view.addSubview(profileImageView)
		profileImageView.snp.makeConstraints { make in
			make.centerX.equalToSuperview()
			make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
			make.bottom.lessThanOrEqualTo(welcomeLabel.snp.top).offset(20)
		}

		// Do any additional setup after loading the view.
	}

	@objc private func handleSignOutTap() {
		GIDService.signOut()
		navigationController?.popViewController(animated: true)
	}

}
