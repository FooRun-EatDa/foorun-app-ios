import Foundation

enum EventAPI {
    case eventList(page: Int)
    case validCheck(id: Int)
    case useCoupon(id: Int)
}

extension EventAPI: RequestNeeds {
    var baseURL: URL {
        guard let url = URL(string: "http://api.foorun.co.kr/") else { fatalError() }

        return url
    }

    var path: String {
        switch self {
        case .eventList(let page):
            return "event?page=\(page)"
        case .validCheck(let id):
            return "event/\(id)/validCheck"
        case .useCoupon(let id):
            return "event/\(id)"
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .eventList(page: _), .validCheck(id: _):
            return .get
        case .useCoupon(id: _):
            return .delete
        }
    }
}
