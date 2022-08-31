//
//  Persistence.swift
//  TransactionRepository
//
//  Created by Toju on 8/29/22.
//

protocol TransactionDatasource {
    
    func getTransactions(completion: @escaping ((Result<[Transaction], CustomErrors>) -> Void))
    func saveTransactions(data: [Transaction], completion: @escaping ((Result<String, CustomErrors>) -> Void))
    func deleteTransactions(data: Transaction)
    
}


class TransactionRepository: TransactionDatasource {
    
    
    var persistence: iPersistence
    
    init(persistence: iPersistence) {
        self.persistence = persistence
    }
    
    func getTransactions(completion: @escaping ((Result<[Transaction], CustomErrors>) -> Void)) {
        
    }
    
    func saveTransactions(data: [Transaction], completion: @escaping ((Result<String, CustomErrors>) -> Void)) {
        
    }
    
    func deleteTransactions(data: Transaction) {
        
    }
 
    
}
