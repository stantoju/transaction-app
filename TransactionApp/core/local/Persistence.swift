//
//  Persistence.swift
//  TransactionApp
//
//  Created by Toju on 8/30/22.
//

import Foundation


protocol iPersistence {
    func saveItem<T>(data: T, completion: @escaping (Result<String, CustomErrors>) -> Void)
    func getItems(completion: @escaping (Result<[Transaction], CustomErrors>) -> Void)
}


class Persistence: iPersistence {
    
    
    func saveItem<T>(data: T, completion: @escaping (Result<String, CustomErrors>) -> Void) {
        
    }
    
    func getItems<T>(completion: @escaping (Result<T, CustomErrors>) -> Void) {
        
    }
    
    
}
