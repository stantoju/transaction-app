//
//  TransactionUsecase.swift
//  TransactionApp
//
//  Created by Toju on 8/30/22.
//

import Foundation

protocol iTransactionUsecase {
    func getTransactions(completion: @escaping (([Transaction]) -> Void))
    func saveTransactions(transaction: Transaction, completion: @escaping ((Bool) -> Void))
    func savemultipleTransactions(transaction: [Transaction], completion: @escaping ((Bool) -> Void))
    func deleteTransactions(transaction: Transaction, completion: @escaping ((Bool) -> Void))
    func truncateDatabase()
}

class TransactionUsecase: iTransactionUsecase {
    
    private let repository: TransactionDatasource
    
    init(repository: TransactionDatasource) {
        self.repository = repository
    }
    
    
    func deleteTransactions(transaction: Transaction, completion: @escaping ((Bool) -> Void)) {
        repository.deleteTransactions(data: transaction) { res in
            switch res {
            case .success(let result):
                completion(result)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
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

    
    func saveTransactions(transaction: Transaction, completion: @escaping ((Bool) -> Void)) {
        repository.saveTransactions(data: transaction) { res in
            switch res {
            case .success(_):
                completion(true)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    
    func savemultipleTransactions(transaction: [Transaction], completion: @escaping ((Bool) -> Void)) {
        repository.saveMultipleTransactions(data: transaction) { res in
            switch res {
            case .success(_):
                completion(true)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    
    func truncateDatabase() {
        repository.truncateDatabase()
    }
    
    
}
