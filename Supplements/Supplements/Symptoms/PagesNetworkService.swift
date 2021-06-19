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
//			.responseJSON(completionHandler: { json in
//				print(json)
//			})
			.response { [weak self] response in
			switch response.result {
			case .success(let json):
				guard let jsonUnwrapped = json else {
					completion(.failure(RequestError.network))
					return
				}
				do {
					guard let pages = (try self?.decoder.decode([Page].self, from: jsonUnwrapped)) else {
						completion(.failure(RequestError.decoding))
						return
					}
					completion(.success(pages))
				} catch let error {
					completion(.failure(error))
				}
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
}
