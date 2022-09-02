//
//  Persistence.swift
//  TransactionRepository
//
//  Created by Toju on 8/29/22.
//

protocol TransactionDatasource {
    
    func getTransactions(completion: @escaping ((Result<[Transaction], CustomErrors>) -> Void))
    func saveTransactions(data: Transaction, completion: @escaping ((Result<String, CustomErrors>) -> Void))
    func saveMultipleTransactions(data: [Transaction], completion: @escaping ((Result<String, CustomErrors>) -> Void))
    func deleteTransactions(data: Transaction, completion: @escaping ((Result<Bool, CustomErrors>) -> Void))
    func truncateDatabase()
    
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
    
    func saveMultipleTransactions(data: [Transaction], completion: @escaping ((Result<String, CustomErrors>) -> Void)) {
        persistence.saveItem(data: data, completion: completion)
    }
    
    
    func deleteTransactions(data: Transaction, completion: @escaping ((Result<Bool, CustomErrors>) -> Void)) {
        persistence.deleteItem(data: data, completion: completion)
    }
    
    
    func truncateDatabase() {
        persistence.clearDatabase()
    }
    
}
