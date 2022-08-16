import Foundation
import UIKit

extension UILabel {
    var paragraphSpacing: CGFloat {
        get { return 0 }
        set {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.paragraphSpacing = newValue
            let attributedString = NSMutableAttributedString(string: self.text ?? "", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
            self.attributedText = attributedString
        }
    }
}
