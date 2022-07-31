import Foundation
import UIKit

//

struct EventNetworkManager {
    let apiType: EventAPI
    var request: URLRequest {

        return APIRequestManager.makeURLRequest(apiType)
    }

    init(apiType: EventAPI) {
        self.apiType = apiType
    }

    static func fetchImage(url: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: url) else { return }

        do {
            let data = try Data(contentsOf: url)
            guard let image = UIImage(data: data) else { return }
            completion(image)
        } catch {
            completion(nil)
        }
    }

    static func fetchEventList(page: Int, completion: @escaping ((Result<Event, NetworkError>) -> Void)) {
        let apiType = EventAPI.eventList(page: page)
        let request = APIRequestManager.makeURLRequest(apiType)
        APIRequestManager.makeRequest(request: request, model: Event.self) { result in
            completion(result)
        }
    }

    func fetchCouponValidCode(completion: @escaping ((Result<EventValid, NetworkError>) -> Void)) {
        APIRequestManager.makeRequest(request: request, model: EventValid.self) { result in
            completion(result)
        }
    }

    func deleteCoupon(completion: @escaping ((NetworkError?) -> Void)) {
        APIRequestManager.makeRequest(request: request, model: Event.self) { result in
            switch result {
            case .success(_):
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
}
