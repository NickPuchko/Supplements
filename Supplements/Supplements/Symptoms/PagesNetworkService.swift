//
//  PagesNetworkService.swift
//  Supplements
//
//  Created by Nikolai Puchko on 19.06.2021.
//

import Foundation
import Alamofire

class PagesNetworkService: NetworkService {
	func getPages(completion: @escaping (Result<[Page], Error>) -> Void) {
		guard let url = makeURL(path: "/iherb/get_questions") else {
			completion(.failure(RequestError.network))
			return
		}
		print(url)

		AF.request(url)
			.validate()
			.response { [weak self] response in
			switch response.result {
			case .success(let json):
				guard let jsonUnwrapped = json else {
					completion(.failure(RequestError.network))
					return
				}
				do {
					let data = String(data: jsonUnwrapped, encoding: .nonLossyASCII)?.data(using: .utf8)
					guard let pages = (try self?.decoder.decode(PageContract.self, from: data!)) else {
						completion(.failure(RequestError.decoding))
						return
					}
					completion(.success([]))
				} catch let error {
					completion(.failure(error))
				}
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
}
