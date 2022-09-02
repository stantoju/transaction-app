//
//  Persistence.swift
//  TransactionApp
//
//  Created by Toju on 8/30/22.
//

import CoreData


protocol iPersistence {
    func saveItem<T>(data: T, completion: @escaping (Result<String, CustomErrors>) -> Void)
    func getItems(completion: @escaping (Result<[Transaction], CustomErrors>) -> Void)
    func deleteItem(data: Transaction, completion: @escaping (Result<Bool, CustomErrors>) -> Void)
    func clearDatabase()
}


class Persistence: iPersistence {
    
    let persistenceController: PersistenceController
    
    init(persistenceController: PersistenceController) {
        self.persistenceController = persistenceController
    }
    
    func saveItem<T>(data: T, completion: @escaping (Result<String, CustomErrors>) -> Void) {
        
        if let transaction = data as? Transaction {
            let entity = TransactionEntity(context: persistenceController.container.viewContext)
            entity.id = transaction.id
            entity.amount = transaction.amount
            entity.type = transaction.type.rawValue
            entity.title = transaction.title
            entity.date = transaction.date
            persistenceController.saveContext()
            completion(.success("success"))
        }
        
        else if let mutltipleTransactions = data as? [Transaction] {
            for transaction in mutltipleTransactions {
                let entity = TransactionEntity(context: persistenceController.container.viewContext)
                entity.id = transaction.id
                entity.amount = transaction.amount
                entity.type = transaction.type.rawValue
                entity.title = transaction.title
                entity.date = transaction.date
                persistenceController.saveContext()
                completion(.success("success"))
            }
        }
        else {
            completion(.failure(.persistenceError(s: "Error pesisting entity")))
        }
    }
    
    func getItems(completion: @escaping (Result<[Transaction], CustomErrors>) -> Void) {
        let fetchRequest: NSFetchRequest<TransactionEntity> = TransactionEntity.fetchRequest()
        do {
            let transactionEntities = try persistenceController.container.viewContext.fetch(fetchRequest)
            let transactions = map_TransactionEntity_Array_To_TransactionDomain_Array(entities: transactionEntities)
            completion(.success(transactions))
        } catch {
            completion(.failure(.persistenceError(s: "Error fetching local data")))
        }
    }
    
    
    func deleteItem(data: Transaction, completion: @escaping (Result<Bool, CustomErrors>) -> Void) {
            guard let entity = get_Existing_TransactionEntity_With_TransactionDomain(transaction: data) else {
                return
            }
            let context = persistenceController.container.viewContext
            context.delete(entity)
            completion(.success(true))
    }
    
    
    
    
    func clearDatabase() {
        // Fetch objects
        let fetchRequest: NSFetchRequest<TransactionEntity> = TransactionEntity.fetchRequest()
        do {
            let transactionEntities = try persistenceController.container.viewContext.fetch(fetchRequest)
            // Loop and delete
            for object in transactionEntities {
                let context = persistenceController.container.viewContext
                context.delete(object)
                    }
        } catch {
            print("Unable to clear DB")
        }
    }
    
}


extension Persistence {
    private func map_TransactionEntity_Array_To_TransactionDomain_Array(entities: [TransactionEntity]) -> [Transaction] {
        return entities.map{ Transaction(id: $0.id ?? UUID(), title: $0.title ?? "", type: TransactionType(rawValue: $0.type!) ?? .income, amount: $0.amount, date: $0.date ?? Date())}
    }
    
    private func get_Existing_TransactionEntity_With_TransactionDomain(transaction: Transaction) -> TransactionEntity? {
        let fetchRequest: NSFetchRequest<TransactionEntity> = TransactionEntity.fetchRequest()
        fetchRequest.fetchLimit = 1
        
        // Filter by ID
        fetchRequest.predicate = NSPredicate(format: "id == %@", transaction.id as CVarArg)
        let context = persistenceController.container.viewContext
        let entity = try? context.fetch(fetchRequest).first
        return entity
    }
}
