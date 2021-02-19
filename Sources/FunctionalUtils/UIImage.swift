//
//  File.swift
//  
//
//  Created by Franco Consoni on 12/01/2021.
//

import Foundation
import Cocoa

public typealias UIImage = NSImage

extension NSImage {
    var cgImage: CGImage? {
        var proposedRect = CGRect(origin: .zero, size: size)

        return cgImage(forProposedRect: &proposedRect,
                       context: nil,
                       hints: nil)
    }
}
