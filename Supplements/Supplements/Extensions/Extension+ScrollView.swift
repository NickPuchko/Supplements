//
//  Extension+ScrollView.swift
//  Supplements
//
//  Created by Максим Сурков on 19.06.2021.
//

import Foundation
import UIKit

extension UIScrollView {

    func scrollToTop(animated: Bool) {
        let topOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(topOffset, animated: animated)
    }
}
