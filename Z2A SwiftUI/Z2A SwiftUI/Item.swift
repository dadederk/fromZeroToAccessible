//
//  Item.swift
//  Z2A SwiftUI
//
//  Created by Dani on 19/01/2025.
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
