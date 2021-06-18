//
//  LoginModel.swift
//  Supplements
//
//  Created by Nikolai Puchko on 18.06.2021.
//
//

import Foundation
import UIKit

class LoginModel {
	weak var viewController: LoginViewController!
    
	init(_ viewController: LoginViewController) {
		self.viewController = viewController
    }
    
}
