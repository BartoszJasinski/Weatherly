//
// Created by ITT on 05/06/2022.
//

import UIKit

final class UIConstants
{
    // Corner
    static let cornerRadius: CGFloat = 12.0
    static let mediumCornerRadius: CGFloat = 6.0
    static let smallCornerRadius: CGFloat = 4.0

    // Border
    static let borderSize: CGFloat = 1.0
    static let noBorderSize: CGFloat = 0.0

    // Shadow
    static let alphaForShadow: Float = 0.1
    static let alphaForSecondShadow: Float = 0.05
    static let x: CGFloat = 0.0
    static let y: CGFloat = 4.0
    static let blur: CGFloat = 8.0
    static let blurForSecondShadow: CGFloat = 24.0
    static let spread: CGFloat = 0.0

    // Margin
    static let marginSmall: CGFloat = 8
    static let marginMedium: CGFloat = 16
    static let marginBig: CGFloat = 32

    // Text Field
    static let maxTextFieldLength = 9
    static let padding: CGFloat = 15

    // Animation
    static let animationDuration = 0.2

    // Section header
//    static let headerFontSize: CGFloat = 14

    // Search input
    static let minimumSearchTextLength = 3
    static let debounceTime: Int = 700

    // Table view
    static let distanceFromTableViewBottomWhenRefresh = UIScreen.main.bounds.size.width / 4

}