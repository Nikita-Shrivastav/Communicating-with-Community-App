import Foundation

// MARK: - Data Model

/// Category for communication items
enum ItemCategory: Sendable, Equatable {
    case need
    case want
    case feeling
}

/// Represents an item in the communication board (needs, wants, or feelings)
struct NeedItem: Identifiable, Sendable {
    let id = UUID()
    let image: String
    let text: String
    let category: ItemCategory
}
