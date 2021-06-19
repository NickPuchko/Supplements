//
//  UserNetworkService.swift
//  Supplements
//
//  Created by Nikolai Puchko on 18.06.2021.
//

import Foundation
import Alamofire

class NetworkService {
	lazy var encoder: JSONEncoder = {
		var result = JSONEncoder()
		result.keyEncodingStrategy = .convertToSnakeCase
		return result
	}()

	lazy var decoder: JSONDecoder = {
		var result = JSONDecoder()
		result.keyDecodingStrategy = .convertFromSnakeCase
		return result
	}()

	func makeURL(path: String) -> URL? {
		var baseComponents = URLComponents()
		baseComponents.scheme = "http"
		baseComponents.host = "venisoking.ru"
		baseComponents.path = path
		return baseComponents.url
	}
}

class UserNetworkService: NetworkService {
	func createUser(user: String, completion: @escaping (Result<String, Error>) -> Void) {
		guard let url = makeURL(path: "/iherb/add_person") else {
			completion(.failure(RequestError.url))
			return
		}

		do {
			let data = try encoder.encode(user)
			AF.upload(data,
					  to: url)
				.validate()
				.response { [weak self] response in
				switch response.result {
				case .success(let json):
					guard let jsonUnwrapped = json else {
						completion(.failure(RequestError.network))
						return
					}

					do {
						
						guard let user = try self?.decoder.decode(String.self, from: jsonUnwrapped) else {
							completion(.failure(RequestError.decoding))
							return
						}
						completion(.success(user))
					} catch let error {
						completion(.failure(error))
					}
				case .failure(let error):
					guard let status = response.response?.statusCode else {
						completion(.failure(error))
						return
					}
					switch status {
					case 400:
						completion(.failure(RequestError.network))
						return
					case 500..<600:
						completion(.failure(RequestError.serverInternal))
						return
					default:
						completion(.failure(error))
						return
					}
				}
			}
		}
		catch let error {
			completion(.failure(error))
		}
	}
}
