import Foundation

extension String {
    func convertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd H:mm:ss"
        if let date = dateFormatter.date(from: self) {

            return date
        } else {

            return nil
        }
    }

    func dateConvertable() -> String {
        var formattedString = self.replacingOccurrences(of: "/", with: "-")
        formattedString = "20" + formattedString + ":00"

        return formattedString
    }
}
