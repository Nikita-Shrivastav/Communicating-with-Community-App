//
//  Item.swift
//  Communicating with Community
//
//  Created by nikita on 9/17/25.
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
