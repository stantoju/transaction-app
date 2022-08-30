//
//  Persistence.swift
//  TransactionRepository
//
//  Created by Toju on 8/29/22.
//

protocol TransactionDatasource {
    
    func getTransactions(completion: @escaping ((Result<[Transaction], Error>) -> Void))
    func saveTransactions(transaction: Transaction)
    
}


class TransactionRepository: TransactionDatasource {
    
    func getTransactions(completion: @escaping ((Result<[Transaction], Error>) -> Void)) {
        
    }
    
    
    func saveTransactions(transaction: Transaction) {
        
    }
    
    
}
