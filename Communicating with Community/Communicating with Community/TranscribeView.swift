// TranscribeView.swift — superseded by "TranscribeView 2.swift"
// All types in this file are private and prefixed with _Old to avoid any conflicts.
import SwiftUI

// MARK: - Placeholder (replaces old TranscribeView — real one is in TranscribeView 2.swift)

private struct _UnusedTranscribeViewPlaceholder: View {
    var body: some View { EmptyView() }
}

// MARK: - Old supporting types (kept private, renamed, body simplified to avoid stale references)

private struct _OldTranscriptBubble: View {
    var body: some View { EmptyView() }
}

private struct _OldTypingIndicator: View {
    var body: some View { EmptyView() }
}

private enum _OldRectCorner {
    case bottomLeft, bottomRight
}

private struct _OldRoundedCornerShape: Shape {
    let radius: CGFloat
    let corners: _OldRectCorner
    func path(in rect: CGRect) -> Path { Path() }
}
