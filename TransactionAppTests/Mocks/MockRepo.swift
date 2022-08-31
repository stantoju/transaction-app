//
//  MockRepo.swift
//  TransactionAppTests
//
//  Created by Toju on 8/30/22.
//


import Foundation
@testable import TransactionApp

class MockRepository: TransactionDatasource {
    
    private let persistence: iPersistence
    
    init(persistence: iPersistence) {
        // inserting abstract dependency
        self.persistence = persistence
    }
    
    func getTransactions(completion: @escaping ((Result<[Transaction], CustomErrors>) -> Void)) {
        persistence.getItems { res in
            switch res {
            case .success(let result):
                // returning result from persistence
                completion(.success(result))
            case .failure(let err):
                // converting to custom error
                completion(.failure(.unknownResponse(s: err.localizedDescription)))
            }
        }
    }
    
    
    func saveTransactions(data: Transaction, completion: @escaping ((Result<String, CustomErrors>) -> Void)) {
        persistence.saveItem(data: data) { res in
            switch res {
            case .success(let result):
                // returning result from persistence
                completion(.success(result))
            case .failure(let err):
                // converting to custom error
                completion(.failure(.unknownResponse(s: err.localizedDescription)))
            }
        }
    }
    
    func deleteTransactions(data: Transaction) {
        persistence.deleteItem(data: data)
    }
    
    
}
