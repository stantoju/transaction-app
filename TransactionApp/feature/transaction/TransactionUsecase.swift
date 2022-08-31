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
    func deleteTransactions(transaction: Transaction)
}

class TransactionUsecase: iTransactionUsecase {
    
    private let repository: TransactionDatasource
    
    init(repository: TransactionDatasource) {
        self.repository = repository
    }
    
    func deleteTransactions(transaction: Transaction) {
        repository.deleteTransactions(data: transaction)
    }
    
    func getTransactions(completion: @escaping (([Transaction]) -> Void)) {
        repository.getTransactions { res in
            switch res {
            case .success(let result):
                completion(result)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func saveTransactions(transaction: Transaction) {
        repository.saveTransactions(data: transaction) { _ in }
    }
    
    
}
