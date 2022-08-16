import Foundation
import UIKit

enum FontType {
    case ultraLight, light, regular, medium, semiBold, bold

    var fontName: String {
        switch self {
        case .ultraLight:
            return "AppleSDGothicNeo-UltraLight"
        case .light:
            return "AppleSDGothicNeo-Light"
        case .regular:
            return "AppleSDGothicNeo-Regular"
        case .medium:
            return "AppleSDGothicNeo-Medium"
        case .semiBold:
            return "AppleSDGothicNeo-SemiBold"
        case .bold:
            return "AppleSDGothicNeo-Bold"
        }
    }
}

extension UIFont {
    static func appleGothicFont(ofSize fontSize: CGFloat, weight: FontType) -> UIFont {

        return UIFont(name: weight.fontName, size: fontSize) ?? .systemFont(ofSize: fontSize)
    }
}
