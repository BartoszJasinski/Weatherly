//
// Created by ITT on 11/06/2022.
//

import UIKit

extension UILabel {
    convenience init(font: UIFont = .systemFont(ofSize: UIConstants.tinyFontSize), textColor: UIColor = .white) {
        self.init()

        _ = setupLook(font: font, textColor: textColor)
    }

    func setupLook(font: UIFont = .systemFont(ofSize: UIConstants.tinyFontSize), textColor: UIColor = .white) -> UILabel {
        self.font = font
        textAlignment = .center
        self.textColor = textColor
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}