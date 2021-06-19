//
//  PagesNetworkService.swift
//  Supplements
//
//  Created by Nikolai Puchko on 19.06.2021.
//

import Foundation
import Alamofire
import SwiftyJSON

class PagesNetworkService: NetworkService {
	func getPages(completion: @escaping (Result<[Page], Error>) -> Void) {
		guard let url = makeURL(path: "/iherb/get_questions") else {
			completion(.failure(RequestError.network))
			return
		}
		AF.request(url)
			.validate()
			.responseJSON { response in
			switch response.result {
			case .success(let data):
				let json = JSON(data)
				var pages: [Page] = []
				for (_, page) in json["data"] {
					pages.append(
						Page(
							index: page["index"].intValue,
							header: (page["header"].arrayObject! as! [String]).map { Element($0) },
							questions: page["questions"].dictionaryObject as? [String: [String]] ?? [:]
						)
					)
				}
				completion(.success(pages))

			case .failure(let error):
				completion(.failure(error))
			}
		}
	}

	func sendRowData(rowData: RowData, completion: @escaping (Result<Any, RequestError>) -> Void) {
		guard let url = makeURL(path: "/iherb/decide") else {
			completion(.failure(RequestError.network))
			return
		}
		guard let data = try? encoder.encode(rowData) else {
			completion(.failure(.decoding))
			return
		}
		AF.upload(data, to: url)
			.validate()
			.responseJSON { response in
			switch response.result {
			case .success(let data):
				let json = JSON(data)

				print(json)
				completion(.success([]))

			case .failure(_):
				completion(.failure(.network))
			}
		}
	}
}
