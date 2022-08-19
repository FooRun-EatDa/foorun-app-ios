import Foundation
import UIKit

extension UIViewController {
    func showsAlert(
        controller: UIAlertController,
        actions: [UIAlertAction]...)
    {
        actions.forEach { controller.addActions($0) }
        self.present(controller, animated: true)
    }
}
