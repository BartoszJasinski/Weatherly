//
// Created by ITT on 07/06/2022.
//

import Foundation

extension String {
     var urlEncoding: String { addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "" }
}