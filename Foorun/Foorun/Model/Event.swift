import Foundation

struct Event: Decodable {
    let validCode: Int
    let eventInfos: [EventInfo]
    let message: String

    enum CodingKeys: String, CodingKey {
        case validCode = "code"
        case eventInfos = "data"
        case message
    }
}

struct EventInfo: Decodable {
    let description: String
    let expiredDate: String
    let id: Int
    let imageURL: String?
    let eventName: String
    let notices: [String]
    let restaurantName: String
    let status: String

    enum CodingKeys: String, CodingKey {
        case description = "desc"
        case eventName = "name"
        case notices = "notice"
        case expiredDate, id, imageURL, restaurantName, status
    }
}
