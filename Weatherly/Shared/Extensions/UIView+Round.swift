//
// Created by ITT on 09/06/2022.
//

import UIKit

extension UIView {
    func round() {
        layer.cornerRadius = UIConstants.cornerRadius
        layer.masksToBounds = true
    }

    func createBorder(borderSize: CGFloat = UIConstants.borderSize, borderColor: CGColor) {
        layer.borderWidth = borderSize
        layer.borderColor = borderColor
    }
}