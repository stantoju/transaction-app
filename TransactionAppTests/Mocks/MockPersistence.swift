//
//  MockPersistence.swift
//  TransactionAppTests
//
//  Created by Toju on 8/30/22.
//

import Foundation
@testable import TransactionApp


class MockPersistence: iPersistence {
    
    var successType = true
    var transactionStorage = [Transaction]()
    
    func saveItem<T>(data: T, completion: @escaping ((Result<String, CustomErrors>) -> Void)) {
        if successType {
            if let transaction = data as? Transaction {
            transactionStorage.append(transaction)
                completion(.success("success"))
            }
            else if let transactions = data as? [Transaction] {
                transactionStorage.append(contentsOf: transactions)
                completion(.success("success"))
            } else {
                completion(.failure(.unknownResponse(s: "Something went wrong")))
            }
        }
        else {
            completion(.failure(.unknownResponse(s: "Something went wrong")))
        }
    }
    
    func getItems<T>(completion: @escaping (Result<T, CustomErrors>) -> Void) {
        if successType {
            completion(.success(transactionStorage as! T))
        } else {
            completion(.failure(.unknownResponse(s: "Something went wrong")))
        }
    }
    
    func deleteItem(data: Transaction) {
        transactionStorage = transactionStorage.filter { return $0.id != data.id}
    }
    
    func deleteItem(data: Transaction, completion: @escaping (Result<Bool, CustomErrors>) -> Void) {
        if successType {
            transactionStorage = transactionStorage.filter { return $0.id != data.id}
            completion(.success(true))
        } else {
            completion(.failure(.unknownResponse(s: "Something went wrong")))        }
    }
    
    func clearDatabase() {
    }
    
    
}
