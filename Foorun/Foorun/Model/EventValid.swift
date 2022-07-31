import Foundation
import UIKit

struct EventValid: Decodable {
    let code: Int
    let data: ValidInfo
    let message: String
}

struct ValidInfo: Decodable {
    let content: String
    let status: Int
}
