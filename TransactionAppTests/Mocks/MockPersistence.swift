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
            let transactions = data as! [Transaction]
            transactionStorage.append(contentsOf: transactions)
            completion(.success("success"))
        } else {
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
    
    
}
