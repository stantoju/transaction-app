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
    
    
    func test_Save_Transaction() throws {
        // save a transaction
        let transaction = Transaction(id: UUID(), title: "Transaction 2", type: .expenses, amount: 149.99, date: Date())
        usecase.saveTransactions(transaction: transaction) { r in
            XCTAssertTrue(r)
        }
    }
    

    func test_GetTransactions() throws {
        // save a transaction
        let transaction = Transaction(id: UUID(), title: "Transaction 2", type: .expenses, amount: 149.99, date: Date())
        usecase.saveTransactions(transaction: transaction) { _ in
            self.usecase.getTransactions { res in
                XCTAssertNotNil(res)
                XCTAssertTrue((res as Any) is [Transaction])
                XCTAssertEqual(res.count, 1)
            }
        }
    }
    
    func test_Save_Multiple_Transactions() throws {
        // save a transaction
        let transaction2 = Transaction(id: UUID(), title: "Transaction 2", type: .expenses, amount: 149.99, date: Date())
        let transaction1 = Transaction(id: UUID(), title: "Transaction 2", type: .expenses, amount: 149.99, date: Date())
        let t = [transaction1, transaction2]
        usecase.savemultipleTransactions(transaction: t) { _ in
            self.usecase.getTransactions { res in
                XCTAssertNotNil(res)
                XCTAssertTrue((res as Any) is [Transaction])
                XCTAssertEqual(res.count, 2)
            }
        }
    }
    
    func test_Delete_Transactions() throws {
        // save a transaction
        let t = Transaction(id: UUID(), title: "Transaction 2", type: .expenses, amount: 149.99, date: Date())
        usecase.saveTransactions(transaction: t) { _ in
            self.usecase.deleteTransactions(transaction: t) { r in
                XCTAssertTrue(r)
            }
            self.usecase.getTransactions { res in
                XCTAssertNotNil(res)
                XCTAssertTrue(res.isEmpty)
            }
        }
    }
    
    fileprivate func generateUsecase() -> TransactionUsecase {
        let persistence = MockPersistence()
        let repo = MockRepository(persistence: persistence)
        let uc = TransactionUsecase(repository: repo)
        return uc
    }

}
