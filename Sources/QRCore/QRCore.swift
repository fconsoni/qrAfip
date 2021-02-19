//
//  QRCore.swift
//  
//
//  Created by Franco Consoni on 12/01/2021.
//

import Foundation
import FunctionalUtils

public class QRCore {
    private let argument: String?
    
    public init(arguments: [String] = CommandLine.arguments) {
        self.argument = arguments.tail().first
    }
    
    public func run() throws {
        guard let argument = self.argument else {
            throw QRError.missingArgument
        }
        
        print("Encoding: " + argument)
        
        try QRGenerator(for: argument).generate()
    }
}

infix operator <<: CompositionPrecedence
