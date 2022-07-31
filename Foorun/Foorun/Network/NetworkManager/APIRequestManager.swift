import Foundation
import UIKit

protocol APIRequest {
    static func makeRequest<T: Decodable>(request: URLRequest, model: T.Type, completion: @escaping ((Result<T, NetworkError>) -> Void))
}

class APIRequestManager: APIRequest {
    private let header: [String: String] = [
        "Content-Type": "application/json",
        "Authorization": "Bearer eyJhbGciOiJIUzUxMiJ9.eyJtZW1iZXJJZCI6MSwicm9sZSI6IkFETUlOIiwiZW1haWwiOiJjaGEyLmhvb25AZ21haWwuY29tIiwibmlja25hbWUiOiLssYTtm4jssYTtm4jssYTtm4giLCJpYXQiOjE2NTkyNDI5MzEsImV4cCI6MTY1OTI0NDczMX0.OzmT8ntPfm8fYrR85EZkkJQxRoecMRJomuvmGU-KmhwCxR8NysmLnbFqg8tpAd4b1TD4NfNHocgfixBrNIwHBg",
        "X-Refresh-Token": "eyJhbGciOiJIUzUxMiJ9.eyJtZW1iZXJJZCI6MSwiaWF0IjoxNjU5MjQyOTMxLCJleHAiOjE2NTk4NDc3MzF9.EBVn9chPar37OaCci9kFrwyg8Uw1xyazDquiqmSStYGhjAxLSb12N2VdiyCDaJ0KFC_dKEiaNXSi8D4UwolFlA"
    ]

    static func makeURLRequest(_ target: RequestNeeds) -> URLRequest {
        let header: [String: String] = [
            "Content-Type": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzUxMiJ9.eyJtZW1iZXJJZCI6MSwicm9sZSI6IkFETUlOIiwiZW1haWwiOiJjaGEyLmhvb25AZ21haWwuY29tIiwibmlja25hbWUiOiLssYTtm4jssYTtm4jssYTtm4giLCJpYXQiOjE2NTkyNDI5MzEsImV4cCI6MTY1OTI0NDczMX0.OzmT8ntPfm8fYrR85EZkkJQxRoecMRJomuvmGU-KmhwCxR8NysmLnbFqg8tpAd4b1TD4NfNHocgfixBrNIwHBg",
            "X-Refresh-Token": "eyJhbGciOiJIUzUxMiJ9.eyJtZW1iZXJJZCI6MSwiaWF0IjoxNjU5MjQyOTMxLCJleHAiOjE2NTk4NDc3MzF9.EBVn9chPar37OaCci9kFrwyg8Uw1xyazDquiqmSStYGhjAxLSb12N2VdiyCDaJ0KFC_dKEiaNXSi8D4UwolFlA"
        ]
        var request = URLRequest(url: target.baseURL.appendingPathComponent(target.path))
        request.httpMethod = target.httpMethod.rawValue
        header.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }

        return request
    }

    static func makeRequest<T>(request: URLRequest, model: T.Type, completion: @escaping ((Result<T, NetworkError>) -> Void)) where T : Decodable {
        let session = URLSession.shared

        session.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(NetworkError.apiIssue))
            }
            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200..<300:
                    guard let data = data else { completion(.failure(.noData)); return }
                    do {
                        let decodedData = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(decodedData))
                    } catch {
                        completion(.failure(NetworkError.unableToDecode))
                    }
                case 400..<500:
                    completion(.failure(NetworkError.clientError))
                case 500..<600:
                    completion(.failure(NetworkError.serverError))
                default:
                    completion(.failure(.failed))
                }
            }
        }.resume()
    }

    static func makeAlertModel(for error: NetworkError) -> UIAlertController.alertModel {
        switch error {
        case .apiIssue:
            let model = UIAlertController.alertModel(title: "요청 API에 문제가 있어요", yesTitle: "OK")
            return model
        case .clientError:
            let model = UIAlertController.alertModel(title: "클라이언트에 문제가 있어요", yesTitle: "OK")
            return model
        case .serverError:
            let model = UIAlertController.alertModel(title: "서버에 문제가 있어요", yesTitle: "OK")
            return model
        case .failed:
            let model = UIAlertController.alertModel(title: "알 수 없는 오류", yesTitle: "OK")
            return model
        case .wrongRequest:
            let model = UIAlertController.alertModel(title: "잘못된 요청이 있어요", yesTitle: "OK")
            return model
        case .noData:
            let model = UIAlertController.alertModel(title: "데이터가 없어요", yesTitle: "OK")
            return model
        case .unableToDecode:
            let model = UIAlertController.alertModel(title: "디코드를 할 수가 없어요", yesTitle: "OK")
            return model
        }
    }
}
