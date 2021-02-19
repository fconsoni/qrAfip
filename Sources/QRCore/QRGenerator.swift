//
//  File.swift
//  
//
//  Created by Franco Consoni on 12/01/2021.
//

import Foundation
import FunctionalUtils
import Cocoa

final class QRGenerator {
    private let argument: String
    private let path = "https://www.afip.gob.ar/fe/qr/?p="
    
    init(for argument: String) {
        self.argument = argument
    }
    
    func generate() throws {
        self.cleanSpace()
        try self.saveNewQr()
    }
    
    private func cleanSpace() {
        try? FileManager.default.removeItem(at: self.rootDir().appendingPathComponent("afipQr.jpg"))
    }
    
    private func saveNewQr() throws {
        if let qr = self.createQr() {
            let bitmap = NSBitmapImageRep(ciImage: qr)
            let data = bitmap.representation(using: NSBitmapImageRep.FileType.jpeg, properties: [.compressionFactor: 0.8])

            do {
                try data?.write(to: self.rootDir().appendingPathComponent("afipQr.jpg"))
            } catch {
                throw QRError.badInput
            }
        }
    }
    
    private func createQr() -> CIImage? {
        if let qrFilter = CIFilter(name: "CIQRCodeGenerator") {
            qrFilter.setValue((self.path + self.argument.data(using: .utf8)!.base64EncodedString()).data(using: .utf8), forKey: "inputMessage")
            
            return qrFilter.outputImage?.transformed(by: CGAffineTransform(scaleX: 3, y: 3))
        } else {
            return .none
        }
    }
    
    private func rootDir() -> URL {
        return Bundle.main.bundleURL
    }
}
