import Foundation
import FoorunKey

struct Event: Decodable {
    let status: Int
    let message: String
    let details: [Detail]?

    enum CodingKeys: String, CodingKey {
        case status = "code"
        case details = "data"
        case message
    }

    struct Detail: Decodable {
        let description: String?
        let expiredDate: String
        let id: Int
        let imageURL: String?
        let eventName: String?
        let notices: [String]?
        let restaurantName: String
        let status: String

        enum CodingKeys: String, CodingKey {
            case description = "desc"
            case eventName = "name"
            case notices = "notice"
            case expiredDate, id, imageURL, restaurantName, status
        }
    }
}


extension Event.Detail {
    static let dummyModel: [Event.Detail] = [
        Event.Detail(description: "여기는 이벤트 설명입니다. 여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.",
                  expiredDate: "22/09/01 12:30",
                  id: 0,
                  imageURL: "https://picsum.photos/200/250",
                  eventName: "파격 세일!!!",
                  notices: [
                    "본 이벤트는 로그인 후 참여하실 수 있습니다.",
                    "본 이벤트는 당사 사정으로 인해 예고없이 종료될 수 있습니다.",
                    "진짜 진짜 쫄깃한 탕수육 먹고 싶다..."
                  ],
                  restaurantName: "식당 이름",
                  status: "0"),
        Event.Detail(description: "여기는 이벤트 설명입니다. 여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.",
                  expiredDate: "22/09/02 12:30",
                  id: 1,
                  imageURL: "https://picsum.photos/250/300",
                  eventName: "파격 세일!!!",
                  notices: [
                    "본 이벤트는 로그인 후 참여하실 수 있습니다.",
                    "본 이벤트는 당사 사정으로 인해 예고없이 종료될 수 있습니다.",
                    "진짜 진짜 쫄깃한 탕수육 먹고 싶다..."
                  ],
                  restaurantName: "식당 이름",
                  status: "0"),
        Event.Detail(description: "여기는 이벤트 설명입니다. 여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.",
                  expiredDate: "22/09/03 12:30",
                  id: 2,
                  imageURL: "https://picsum.photos/300/350",
                  eventName: "파격 세일!!!",
                  notices: [
                    "본 이벤트는 로그인 후 참여하실 수 있습니다.",
                    "본 이벤트는 당사 사정으로 인해 예고없이 종료될 수 있습니다.",
                    "진짜 진짜 쫄깃한 탕수육 먹고 싶다..."
                  ],
                  restaurantName: "식당 이름",
                  status: "0"),
        Event.Detail(description: "여기는 이벤트 설명입니다. 여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.여기는 이벤트 설명입니다.",
                  expiredDate: "22/09/04 12:30",
                  id: 3,
                  imageURL: "https://picsum.photos/350/400",
                  eventName: "파격 세일!!!",
                  notices: [
                    "본 이벤트는 로그인 후 참여하실 수 있습니다. 본 이벤트는 로그인 후 참여하실 수 있습니다. 본 이벤트는 로그인 후 참여하실 수 있습니다. 본 이벤트는 로그인 후 참여하실 수 있습니다. 본 이벤트는 로그인 후 참여하실 수 있습니다. 본 이벤트는 로그인 후 참여하실 수 있습니다. 본 이벤트는 로그인 후 참여하실 수 있습니다. 본 이벤트는 로그인 후 참여하실 수 있습니다. ",
                    "본 이벤트는 당사 사정으로 인해 예고없이 종료될 수 있습니다.",
                    "진짜 진짜 쫄깃한 탕수육 먹고 싶다..."
                  ],
                  restaurantName: "식당 이름",
                  status: "0")
    ]
}
