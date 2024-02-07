//
//  Item.swift
//  BarcodeScannerDemo
//
//  Created by Florian Gromes on 07.02.24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
