import Foundation
import UIKit

extension UIViewController {
    func showAlert(model: UIAlertController.alertModel) {
        let alertController = UIAlertController(title: model.title, message: model.message, preferredStyle: .alert)

        switch model.noTitle {
        case nil:
            let yesAction = UIAlertAction(title: model.yesTitle, style: .default, handler: model.yesHandler)
            alertController.addAction(yesAction)
        default:
            let yesAction = UIAlertAction(title: model.yesTitle, style: .default, handler: model.yesHandler)
            let noAction = UIAlertAction(title: model.noTitle, style: .default, handler: model.noHandler)
            alertController.addActions([yesAction, noAction])
        }

        self.present(alertController, animated: true)
    }
}
