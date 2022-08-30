//
//  Transaction.swift
//  TransactionApp
//
//  Created by Toju on 8/29/22.
//

import Foundation


struct Transaction {
    let id: Int
    let title: String
    let type: TransactionType
    let amount: Float
    let date: Date
}


enum TransactionType {
    case income
    case expenses
}
