import Foundation
import UIKit

extension UIAlertController {
    struct alertModel {
        typealias alertHandler = ((UIAlertAction) -> Void)?

        let title: String
        let message: String?
        let yesTitle: String
        let yesHandler: alertHandler
        let noTitle: String?
        let noHandler: alertHandler

        init(title: String, message: String? = nil, yesTitle: String, yesHandler: alertHandler = nil, noTitle: String? = nil, noHandler: alertHandler = nil) {
            self.title = title
            self.message = message
            self.yesTitle = yesTitle
            self.yesHandler = yesHandler
            self.noTitle = noTitle
            self.noHandler = noHandler
        }
    }

    func addActions(_ actions: [UIAlertAction]) {
        actions.forEach { self.addAction($0) }
    }
}

