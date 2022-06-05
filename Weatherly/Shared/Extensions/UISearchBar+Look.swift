//
// Created by ITT on 05/06/2022.
//

import UIKit

//TODO: Refactor ME
extension UISearchBar {
    func round(cornerRadius: CGFloat = UIConstants.cornerRadius) {
        layer.cornerRadius = cornerRadius
    }


    func setBackgroundColor(_ color: UIColor) {
        for subView in subviews {
            for subSubView in subView.subviews {
                for subSubSubView in subSubView.subviews {
                    let textField = subSubSubView as? UITextField
                    if textField != nil {
                        textField?.backgroundColor = color
                        break
                    }
                }
            }
        }
    }

    func setTextColor(_ color: UIColor) {
        for subView in subviews {
            for subSubView in subView.subviews {
                for subSubSubView in subSubView.subviews {
                    let textField = subSubSubView as? UITextField
                    if textField != nil {
                        textField?.textColor = color
                        break
                    }
                }
            }
        }
    }

    func setIconColor(_ color: UIColor) {
        for subView in subviews {
            for subSubView in subView.subviews {
                for subSubSubView in subSubView.subviews {
                    let textField = subSubSubView as? UITextField
                    if textField != nil {
                        let glassIconView = textField?.leftView as? UIImageView
                        glassIconView?.image = glassIconView?.image?.withRenderingMode(.alwaysTemplate)
                        glassIconView?.tintColor = color
                        break
                    }
                }
            }
        }
    }
}
