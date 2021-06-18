//
//  Errors.swift
//  Supplements
//
//  Created by Nikolai Puchko on 18.06.2021.
//

import Foundation

enum RequestError: Error {
	case url, network, decoding, serverInternal
}
