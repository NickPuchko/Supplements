//
//  User.swift
//  Supplements
//
//  Created by Nikolai Puchko on 18.06.2021.
//

import Foundation
import UIKit

struct GoogleUser: Codable {
	var id: String
	var fullname: String
	var email: String
}

struct User {
	var contract: GoogleUser
	var image: UIImage?
}
