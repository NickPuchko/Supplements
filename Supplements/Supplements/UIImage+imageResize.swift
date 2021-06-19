//
//  UIImage+imageResize.swift
//  Supplements
//
//  Created by Nikolai Puchko on 19.06.2021.
//

import UIKit

extension UIImage {
	func imageResize (sizeChange: CGSize)-> UIImage{
		let hasAlpha = true
		let scale: CGFloat = 0.0 

		UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
		self.draw(in: CGRect(origin: CGPoint.zero, size: sizeChange))

		let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
		return scaledImage!
	}
}
