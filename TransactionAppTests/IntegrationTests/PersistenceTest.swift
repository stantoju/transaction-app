//
//  PersistenceTest.swift
//  TransactionAppTests
//
//  Created by Toju on 8/31/22.
//

import XCTest
import CoreData
@testable import TransactionApp


class PersistenceTest: XCTestCase {
    
    var persistence: Persistence!
    var persistenceController: PersistenceController!
    var context: NSManagedObjectContext!

    override func setUpWithError() throws {
        persistenceController = PersistenceController.init(inMemory: true) // Initialize in-memory persistence container
        persistence = Persistence(persistenceController: persistenceController)
        context = persistenceController.container.viewContext
    }

    override func tearDownWithError() throws {
        persistence = nil
    }

    func test_Save_Item() throws {
        let transaction1 = Transaction(id: UUID(), title: "Transaction 1", type: .income, amount: 400.50, date: Date())
        let exp = expectation(description: "Expectation for saving data")
        persistence.saveItem(data: transaction1) { res in
            switch res {
            case .success(let response):
                XCTAssertTrue((response as Any) is String)
                exp.fulfill()
            case .failure(_):
                XCTFail("Expected success, but got error response")
                exp.fulfill()
            }
        }
        waitForExpectations(timeout: 1.0)
    }
    
    func test_Get_Item() throws {
        // Persist an item first
        let transaction1 = Transaction(id: UUID(), title: "Transaction 1", type: .income, amount: 400.50, date: Date())
        let exp = expectation(description: "Expectation for saving data")
        persistence.saveItem(data: transaction1) { res in
            switch res {
            case .success(_):
                //Get the item after persistence
                self.persistence.getItems { res in
                    switch res {
                    case .success(let response):
                        XCTAssertTrue((response as Any) is [Transaction])
                        XCTAssertEqual(response.count, 1)
                        exp.fulfill()
                    case .failure(_):
                        XCTFail("Expected success, but got error response")
                        exp.fulfill()
                    }
                }
            case .failure(_):
                XCTFail("Expected success, but got error response")
                exp.fulfill()
            }
        }
        waitForExpectations(timeout: 2.0)
    }
    
    
    func test_Delete_Item() throws {
        // Persist an item first
        let transaction1 = Transaction(id: UUID(), title: "Transaction 1", type: .income, amount: 400.50, date: Date())
        let exp = expectation(description: "Expectation for saving data")
        persistence.saveItem(data: transaction1) { res in
            switch res {
            case .success(_):
                // Delete the item after persistence
                self.persistence.deleteItem(data: transaction1)
                // Fetch records after deletion
                self.persistence.getItems { res2 in
                    switch res2 {
                    case .success(let response):
                        XCTAssertTrue((response as Any) is [Transaction])
                        XCTAssertTrue(response.isEmpty)
                        exp.fulfill()
                    case .failure(_):
                        XCTFail("Expected success, but got error response")
                        exp.fulfill()
                    }
                }
            case .failure(_):
                XCTFail("Expected success, but got error response")
                exp.fulfill()
            }
        }
        waitForExpectations(timeout: 2.0)
    }


}
