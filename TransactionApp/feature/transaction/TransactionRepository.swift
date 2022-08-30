//
//  Persistence.swift
//  TransactionRepository
//
//  Created by Toju on 8/29/22.
//

protocol TransactionDatasource {
    
    func getTransactions(completion: @escaping ((Result<[Transaction], CustomErrors>) -> Void))
    func saveTransactions(data: [Transaction], completion: @escaping ((Result<String, CustomErrors>) -> Void))
    
}


class TransactionRepository: TransactionDatasource {
    func saveTransactions(data: [Transaction], completion: @escaping ((Result<String, CustomErrors>) -> Void)) {
        
    }
    
    var persistence: iPersistence
    
    init(persistence: iPersistence) {
        self.persistence = persistence
    }
    
    func getTransactions(completion: @escaping ((Result<[Transaction], CustomErrors>) -> Void)) {
        
    }
    
    func saveTransactions(completion: @escaping ((Result<String, CustomErrors>) -> Void)) {
        
    }
    
    
    
    
}
