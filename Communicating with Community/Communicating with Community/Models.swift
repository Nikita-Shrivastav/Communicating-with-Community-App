import Foundation

// MARK: - Data Model

/// Represents an item in the communication board (needs, wants, or feelings)
struct NeedItem: Identifiable {
    let id = UUID()
    let image: String
    let text: String
    let category: Category
    
    enum Category {
        case need
        case want
        case feeling
    }
}
