//
//  Persistence.swift
//  TransactionRepository
//
//  Created by Toju on 8/29/22.
//

protocol TransactionDatasource {
    
    func getTransactions(completion: @escaping ((Result<[Transaction], CustomErrors>) -> Void))
    func saveTransactions(data: Transaction, completion: @escaping ((Result<String, CustomErrors>) -> Void))
    func deleteTransactions(data: Transaction)
    
}


class TransactionRepository: TransactionDatasource {
    
    
    var persistence: iPersistence
    
    init(persistence: iPersistence) {
        self.persistence = persistence
    }
    
    func getTransactions(completion: @escaping ((Result<[Transaction], CustomErrors>) -> Void)) {
        persistence.getItems(completion: completion)
    }
    
    func saveTransactions(data: Transaction, completion: @escaping ((Result<String, CustomErrors>) -> Void)) {
        persistence.saveItem(data: data, completion: completion)
    }
    
    func deleteTransactions(data: Transaction) {
        persistence.deleteItem(data: data)
    }
 
    
}
