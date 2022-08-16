import Foundation
import UIKit

extension UIAlertController {
    convenience init(
        title: String? = nil,
        message: String? = nil
    ) {
        self.init(title: title, message: message, preferredStyle: .alert)
    }

    func addActions(_ actions: [UIAlertAction]) {
        actions.forEach { self.addAction($0) }
    }
}
