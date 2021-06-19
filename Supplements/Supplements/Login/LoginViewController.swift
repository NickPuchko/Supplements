//
//  LoginViewController.swift
//  Supplements
//
//  Created by Nikolai Puchko on 18.06.2021.
//
//

import Foundation
import UIKit
import SnapKit
import GoogleSignIn

class LoginViewController: UIViewController {
    private lazy var model = LoginModel(self)
	private lazy var googleSignInButton = GIDSignInButton()
	private lazy var GIDService = GIDSignIn.sharedInstance()

    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .black
//		navigationController?.setNavigationBarHidden(true, animated: true)
		GIDService?.presentingViewController = self
		GIDService?.restorePreviousSignIn()

		googleSignInButton.style = .wide
		view.addSubview(googleSignInButton)
		googleSignInButton.snp.makeConstraints { make in
			make.centerX.equalToSuperview()
			make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-80)
			make.width.equalToSuperview().multipliedBy(0.8)
			make.height.equalTo(60)
		}
    }

}
