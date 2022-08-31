//
//  CustomErrors.swift
//  TransactionApp
//
//  Created by Toju on 8/30/22.
//

import Foundation

public enum CustomErrors: Error {
    
    case internalParsingDataError(s: String)
    case generalError(s: String)
    case persistenceError(s: String)
    case unknownResponse(s: String)
    
}
