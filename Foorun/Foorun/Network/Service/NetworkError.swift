import Foundation

enum NetworkError: Error {
    case apiIssue
    case clientError
    case serverError
    case failed
    case wrongRequest
    case noData
    case unableToDecode
}
