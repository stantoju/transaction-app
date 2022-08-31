//
//  TransactionUsecaseTest.swift
//  TransactionAppTests
//
//  Created by Toju on 8/31/22.
//

import XCTest
@testable import TransactionApp

class TransactionUsecaseTest: XCTestCase {
    
    var usecase: TransactionUsecase!

    override func setUpWithError() throws {
        
        usecase = generateUsecase()
    }

    override func tearDownWithError() throws {
        usecase = nil
    }

    func test_GetTransactions() throws {
        // save a transaction
        let transaction = Transaction(id: UUID(), title: "Transaction 2", type: .expenses, amount: 149.99, date: Date())
        usecase.saveTransactions(transaction: transaction)
        usecase.getTransactions { res in
            XCTAssertNotNil(res)
            XCTAssertTrue((res as Any) is [Transaction])
            XCTAssertEqual(res.count, 1)
        }
    }
    
    fileprivate func generateUsecase() -> TransactionUsecase {
        let persistence = MockPersistence()
        let repo = MockRepository(persistence: persistence)
        let uc = TransactionUsecase(repository: repo)
        return uc
    }

}
