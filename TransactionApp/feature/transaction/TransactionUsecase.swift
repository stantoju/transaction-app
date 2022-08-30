//
//  TransactionUsecase.swift
//  TransactionApp
//
//  Created by Toju on 8/30/22.
//

import Foundation

protocol iTransactionUsecase {
    func getTransactions(completion: @escaping (([Transaction]) -> Void))
    func saveTransactions(transaction: Transaction)
}

class TransactionUsecase: iTransactionUsecase {
    func getTransactions(completion: @escaping (([Transaction]) -> Void)) {
        
    }
    
    func saveTransactions(transaction: Transaction) {
        
    }
    
    
}
