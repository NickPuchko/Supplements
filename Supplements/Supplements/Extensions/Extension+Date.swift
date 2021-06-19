//
//  Extension+Date.swift
//  Supplements
//
//  Created by Максим Сурков on 19.06.2021.
//

import Foundation
extension Date {
    init(_ year:Int, _ month: Int, _ day: Int) {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        self.init(timeInterval:0, since: Calendar.current.date(from: dateComponents)!)
    }
}
