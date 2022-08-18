//
//  APIClient.swift
//  Foorun
//
//  Created by 김희진 on 2022/07/31.
//
import Foundation
import Alamofire
import FoorunKey

struct APIResponse<T: Decodable>: Decodable {
    let code: Int
    let data: T?
    let message: String?
}

class API<T: Decodable> {

    enum APIError: Error {
        case failedTogetData
    }

    var fetchURL: String
    var method: HTTPMethod
    var parameters: Parameters

    let headers: HTTPHeaders = [
        "Content-Type":"application/json",
        "Accept": "application/json",
        "Authorization": FoorunKey.Token.guest,
        "X-Refresh-Token": FoorunKey.Token.refresh
    ]

    init (requestString: String, method: HTTPMethod, parameters: Parameters) {
        self.fetchURL = FoorunKey.urlString + requestString
        self.method = method
        self.parameters = parameters
    }

    func fetch(completion: @escaping (APIResponse<T>) -> Void) {
        var encodingType: ParameterEncoding {
            switch self.method {
            case .get, .delete:
                return URLEncoding.default
            case .post, .put:
                return JSONEncoding.default
            default:
                return URLEncoding.default
            }
        }

        NSLog("요청", self.fetchURL)
        print(fetchURL)

        AF.request(self.fetchURL,
                   method: self.method,
                   parameters: self.parameters,
                   encoding: encodingType,
                   headers: headers)
        .validate(statusCode: 200..<300)
        .responseJSON { response in
            switch response.result {
            case .success(let value):
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    let result = try JSONDecoder().decode(APIResponse<T>.self, from: jsonData)
                    completion(result)
                } catch (let err){
                    print("네트워크 에러: ", err.localizedDescription)
                }

            case .failure(let error):
                print("네트워크 에러: ", error.localizedDescription)
            }
        }
    }
}

