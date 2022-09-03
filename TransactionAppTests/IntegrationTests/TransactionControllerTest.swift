//
//  TransactionControllerTest.swift
//  TransactionAppTests
//
//  Created by Toju on 9/2/22.
//

import XCTest
@testable import TransactionApp

class TransactionControllerTest: XCTestCase {
    
    var controller: TransactionController!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        controller = nil
    }

    func test_Populate_and_Get_Transaction() throws {
        controller = setupController()
        XCTAssertTrue((controller.viewModel?.transactions.isEmpty)!)
        let exp = expectation(description: "Expectation for populating data")
        controller.viewModel?.populateDummyData() // Populate
        exp.fulfill()
        let exp2 = expectation(description: "Expectation for fetching data")
        controller.viewModel?.getTransactions() // Get data
        XCTAssertTrue(!(controller.viewModel?.transactions.isEmpty)!)
        exp2.fulfill()
        waitForExpectations(timeout: 1.0)
    }
    
    

    func test_Save_Transaction() throws {
        controller = setupController()
        XCTAssertTrue((controller.viewModel?.transactions.isEmpty)!)
        let exp = expectation(description: "Expectation for populating data")
        let transaction1 = Transaction(id: UUID(), title: "Transaction 1", type: .income, amount: 400.50, date: Date())
        controller.viewModel?.saveTransaction(transaction1) // Save Transaction
        exp.fulfill()
        let exp2 = expectation(description: "Expectation for fetching data")
        controller.viewModel?.getTransactions() // Get data
        XCTAssertTrue(!(controller.viewModel?.transactions.isEmpty)!)
        XCTAssertEqual(controller.viewModel?.transactions.count, 1)
        exp2.fulfill()
        waitForExpectations(timeout: 1.0)
    }
    
    
    func test_Calculate_Statistics() throws {
        controller = setupController()
        let exp = expectation(description: "Expectation for populating data")
        let transaction1 = Transaction(id: UUID(), title: "Transaction 1", type: .income, amount: 400.50, date: Date())
        controller.viewModel?.saveTransaction(transaction1) // Save Transaction
        exp.fulfill()
        let exp2 = expectation(description: "Expectation for fetching data")
        controller.viewModel?.getTransactions() // Get data
        XCTAssertTrue(controller.viewModel?.statistics != nil)
        XCTAssertEqual(controller.viewModel?.statistics.expenses, 0)
        XCTAssertEqual(controller.viewModel?.statistics.income, 400.50)
        XCTAssertEqual(controller.viewModel?.statistics.ratio, 0)
        exp2.fulfill()
        waitForExpectations(timeout: 1.0)
    }
    
    func test_Delete_Transaction() throws {
        controller = setupController()
        XCTAssertTrue((controller.viewModel?.transactions.isEmpty)!)
        let exp = expectation(description: "Expectation for populating data")
        let transaction1 = Transaction(id: UUID(), title: "Transaction 1", type: .income, amount: 400.50, date: Date())
        controller.viewModel?.saveTransaction(transaction1) // Save Transaction
        exp.fulfill()
        let exp2 = expectation(description: "Expectation for fetching data")
        controller.viewModel?.deleteTransaction(transaction1) // Delete data
        XCTAssertTrue((controller.viewModel?.transactions.isEmpty)!)
        exp2.fulfill()
        waitForExpectations(timeout: 1.0)
    }

    
    
    func test_Truncate_Database() throws {
        controller = setupController()
        XCTAssertTrue((controller.viewModel?.transactions.isEmpty)!)
        let exp = expectation(description: "Expectation for populating data")
        let transaction1 = Transaction(id: UUID(), title: "Transaction 1", type: .income, amount: 400.50, date: Date())
        controller.viewModel?.saveTransaction(transaction1) // Save Transaction
        exp.fulfill()
        let exp2 = expectation(description: "Expectation for fetching data")
        controller.viewModel?.clearDatabase() // Clere DB
        controller.viewModel?.getTransactions() // Get data
        XCTAssertTrue((controller.viewModel?.transactions.isEmpty)!)
        exp2.fulfill()
        waitForExpectations(timeout: 1.0)
    }
    
    
    private func setupController() -> TransactionController {
        let persistence = Persistence(persistenceController: PersistenceController.init(inMemory: true))
        let repository = TransactionRepository(persistence: persistence)
        let usecase = TransactionUsecase(repository: repository)
        let viewmodel = TransactionViewmodel(usecase: usecase)
        let vc = TransactionController()
        vc.viewModel = viewmodel
        return vc
    }

}
