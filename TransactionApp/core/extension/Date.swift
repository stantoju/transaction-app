//
//  Date.swift
//  TransactionApp
//
//  Created by Toju on 9/2/22.
//

import Foundation


extension Date {
    func dateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "F MMMM, yyyy"
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
}


extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

