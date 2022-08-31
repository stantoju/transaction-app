//
//  TransactionAppTests.swift
//  TransactionAppTests
//
//  Created by Toju on 8/29/22.
//

import XCTest
@testable import TransactionApp

class TransactionAppTests: XCTestCase {
    
    var repository: MockRepository!
    var persistence: MockPersistence!

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        repository = nil
        persistence = nil
    }

    func test_Save_Transaction_Successfully() throws {
        repository = instanciateRepository()
        let transactions = generateTransactions()
        repository.saveTransactions(data: transactions) { res in
            switch res {
            case .success(let response):
                XCTAssertNotNil(response)
                XCTAssertTrue((response as Any) is String)
                XCTAssertEqual(response, "success")
            case .failure(_):
                XCTFail("Expected success, but got error response")
            }
        }
    }
    

    func test_Get_Transaction_Successfully() throws {
        repository = instanciateRepository()
        // Adding transaction to mock storage
        let transactions = generateTransactions()
        repository.saveTransactions(data: transactions) { _ in}
        // Fetching data
        repository.getTransactions {  res in
            switch res {
            case .success(let response):
                XCTAssertNotNil(response)
                XCTAssertTrue((response as Any) is [Transaction])
                XCTAssertEqual(response.count, 3)
            case .failure(_):
                XCTFail("Expected success, but got error response")
            }
        }
        
    }
    
    func test_Save_Transaction_Failure() throws {
        repository = instanciateRepository(successType: false)
        let transactions = generateTransactions()
        repository.saveTransactions(data: transactions) { res in
            switch res {
            case .success(_):
                XCTFail("Expected failure here, but got success")
            case .failure(let err):
                XCTAssertNotNil(err)
                XCTAssertTrue((err as Any) is CustomErrors)
            }
        }
    }
    

    func test_Get_Transaction_Failure() throws {
        repository = instanciateRepository(successType: false)
        repository.getTransactions {  res in
            switch res {
            case .success(_):
                XCTFail("Expected failure here, but got success")
            case .failure(let err):
                XCTAssertNotNil(err)
                XCTAssertTrue((err as Any) is CustomErrors)
            }
        }
        
    }
    
    
    private func generateTransactions() -> [Transaction]{
        let transaction1 = Transaction(id: UUID(), title: "Transaction 1", type: .income, amount: 400.50, date: Date())
        let transaction2 = Transaction(id: UUID(), title: "Transaction 2", type: .expenses, amount: 149.99, date: Date())
        let transaction3 = Transaction(id: UUID(), title: "Transaction 3", type: .expenses, amount: 180.00, date: Date())
        let transactions = [transaction1, transaction2, transaction3]
        return transactions
    }
    
    private func instanciateRepository(successType: Bool = true) -> MockRepository {
        persistence = MockPersistence()
        persistence.successType = successType // This is to control the kind of mock response returned for testing
        repository = MockRepository(persistence: persistence)
        return repository
    }

}
