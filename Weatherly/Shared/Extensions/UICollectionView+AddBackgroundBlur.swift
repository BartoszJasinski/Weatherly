//
// Created by ITT on 11/06/2022.
//

import UIKit

extension UICollectionView {
    func addBackgroundBlur() {
        backgroundColor = .clear
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        visualEffectView.frame = bounds
        backgroundView = visualEffectView
    }
}