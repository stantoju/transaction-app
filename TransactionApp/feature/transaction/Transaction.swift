//
//  Transaction.swift
//  TransactionApp
//
//  Created by Toju on 8/29/22.
//

import Foundation


struct Transaction {
    let id: UUID
    let title: String
    let type: TransactionType
    let amount: Float
    let date: Date
}

struct GroupedTransaction {
    let date: String
    let content: [Transaction]
}


enum TransactionType: String {
    case income = "income"
    case expenses = "expenses"
}


struct Statistics {
    let income: Float
    let expenses: Float
    let ratio: Float
}
