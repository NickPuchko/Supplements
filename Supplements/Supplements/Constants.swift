//
//  Constants.swift
//  Snap
//
//  Created by Nikolai Puchko on 15.06.2021.
//

import UIKit

enum Images {
  static let google = "google"
}

enum Fonts {
	static let SDGothicNeoLight = UIFont(name: "AppleSDGothicNeo-Light", size: UIFont.systemFontSize)!
	static let SDGothicNeoBold = UIFont(name: "AppleSDGothicNeo-Bold", size: UIFont.systemFontSize)!

}


class InsetLabel: UILabel {
	init(inset: UIEdgeInsets) {
		self.inset = inset
		super.init(frame: .zero)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	let inset: UIEdgeInsets

	override func drawText(in rect: CGRect) {
		let insets: UIEdgeInsets = UIEdgeInsets(top: inset.top, left: inset.left, bottom: inset.bottom, right: inset.right)
		super.drawText(in: rect.inset(by: insets))
	}

	override public var intrinsicContentSize: CGSize {
		var intrinsicSuperViewContentSize = super.intrinsicContentSize
		intrinsicSuperViewContentSize.height += inset.top + inset.bottom
		intrinsicSuperViewContentSize.width += inset.left + inset.right
		return intrinsicSuperViewContentSize
	}
}
