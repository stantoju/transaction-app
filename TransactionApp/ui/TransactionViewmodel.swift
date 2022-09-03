//
//  TransactionViewmodel.swift
//  TransactionApp
//
//  Created by Toju on 8/31/22.
//

import CoreData

class TransactionViewmodel {
    
    @Published var saved = false
    @Published var statistics = Statistics(income: 0, expenses: 0, ratio: 0)
    @Published var transactions = [GroupedTransaction]()
    var rawTransaction = [Transaction]() // For fast UI management
    private let usecase: iTransactionUsecase
    init(usecase: iTransactionUsecase) {
        self.usecase = usecase
    }
    
    func saveTransaction(_ t: Transaction) {
        saved = false
        rawTransaction.append(t) // M fast UI management,
        calculateStatts() // To modify statistics view
        updateTransactions()
        usecase.saveTransactions(transaction: t) { [weak self] _ in
            self?.saved = true
        }
    }
    
    func getTransactions() {
        usecase.getTransactions {[weak self] t in
            guard let wSelf = self else {return}
            wSelf.rawTransaction = t
            wSelf.calculateStatts() // To modify statistics view
            wSelf.updateTransactions()
            let groupedTransaction = wSelf.groupedTransactionsByDate(t)
            var tempTransaction = [GroupedTransaction]()
            for (k, v) in groupedTransaction {
                tempTransaction.append(GroupedTransaction(date: k, content: v))
            }
            wSelf.transactions = tempTransaction
        }
    }
    
    func deleteTransaction(_ transactionToDelete: Transaction) {
        usecase.deleteTransactions(transaction: transactionToDelete) { [weak self] _ in
            self?.getTransactions()
        }
    }
    
    func clearDatabase() {
        usecase.truncateDatabase()
    }
    
    func calculateStatts() {
        var expenses: Float = 0
        var income: Float = 0
        for item in rawTransaction {
            switch item.type {
            case .income:
                income += item.amount
            case .expenses:
                expenses += item.amount
            }
        }
        let ratio = expenses/income
        statistics = Statistics(income: income, expenses: expenses, ratio: ratio)
    }
    
    func updateTransactions() {
        let groupedTransaction = groupedTransactionsByDate(rawTransaction)
        var tempTransaction = [GroupedTransaction]()
        for (k, v) in groupedTransaction {
            tempTransaction.append(GroupedTransaction(date: k, content: v))
        }
        transactions = tempTransaction
    }
    
    
    
    
    func populateDummyData() {
        
        usecase.truncateDatabase()
        
        let yesterday = Calendar.current.date(byAdding: .day, value: -2, to: Date())!
        let dayBefore = Calendar.current.date(byAdding: .day, value: -4, to: Date())!
        let dayBeforeUpper = Calendar.current.date(byAdding: .day, value: -5, to: Date())!
        let today = Date()

//         Load new data set
        let transaction1 = Transaction(id: UUID(), title: "Salary", type: .income, amount: 400.50, date: dayBeforeUpper)
        let transaction2 = Transaction(id: UUID(), title: "Cable Subscription", type: .expenses, amount: 149.99, date: dayBefore)
        let transaction3 = Transaction(id: UUID(), title: "Bus Fare", type: .expenses, amount: 180.00, date: yesterday)
        let transaction4 = Transaction(id: UUID(), title: "Wages", type: .income, amount: 790.50, date: today)
        let transaction5 = Transaction(id: UUID(), title: "Feeding", type: .expenses, amount: 149.99, date: dayBefore)
        let transaction6 = Transaction(id: UUID(), title: "Cinema", type: .expenses, amount: 180.00, date: yesterday)
        let transaction7 = Transaction(id: UUID(), title: "Sales", type: .income, amount: 120.50, date: today)
        let transaction8 = Transaction(id: UUID(), title: "Entertainment", type: .expenses, amount: 399.99, date: today)
        let transaction9 = Transaction(id: UUID(), title: "Stationaries", type: .expenses, amount: 180.00, date: dayBefore)
        let transaction10 = Transaction(id: UUID(), title: "Gift", type: .income, amount: 100, date: today)
        let transaction11 = Transaction(id: UUID(), title: "Donations", type: .income, amount: 200.50, date: today)
        let transaction12 = Transaction(id: UUID(), title: "Entertainment", type: .expenses, amount: 110, date: today)
        let transactions = [transaction1,transaction2,transaction3,transaction4,transaction5,transaction6,transaction7,transaction8,transaction9, transaction10, transaction11, transaction12]
        usecase.savemultipleTransactions(transaction: transactions) {[weak self] _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self?.getTransactions()
             }
        }
        
    }
    
    // Grouping transactions array by date
    func groupedTransactionsByDate(_ transactionArray: [Transaction]) -> [String: [Transaction]] {
      let empty: [String: [Transaction]] = [:]
      return transactionArray.reduce(into: empty) { acc, cur in
          let components = Calendar.current.dateComponents([.day, .month, .year], from: cur.date)
          let date = Calendar.current.date(from: components)!
          let existing = acc[date.dateToString()] ?? []
          acc[date.dateToString()] = existing + [cur]
      }
    }
    
    
    

}
