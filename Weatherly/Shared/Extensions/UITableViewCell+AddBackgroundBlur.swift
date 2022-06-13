//
// Created by ITT on 13/06/2022.
//

import UIKit

extension UITableViewCell {
    func addBackgroundBlur() {
        backgroundColor = .clear
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        visualEffectView.frame = bounds
        backgroundView = visualEffectView
    }
}