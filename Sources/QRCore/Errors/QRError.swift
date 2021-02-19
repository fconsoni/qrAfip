//
//  File.swift
//  
//
//  Created by Franco Consoni on 12/01/2021.
//

import Foundation

public enum QRError: Error, Equatable {
    case missingArgument
    case badInput
    
    public func description() -> String {
        switch self {
        case .missingArgument: return "Missing argument"
        case .badInput: return "Bad format of argument"
        }
    }
}
