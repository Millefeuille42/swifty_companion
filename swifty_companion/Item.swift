//
//  Item.swift
//  swifty_companion
//
//  Created by Millefeuille on 20/06/2024.
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
