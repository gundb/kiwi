import Foundation

enum GestureAction: String, Codable, CaseIterable, Identifiable {
    case none
    case undo
    case redo
    case paste
    case copy
    case cut
    case selectAll
    case eraseWord
    case eraseLine
    case cursorLeft
    case cursorRight

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .none: return "None"
        case .undo: return "Undo"
        case .redo: return "Redo"
        case .paste: return "Paste"
        case .copy: return "Copy"
        case .cut: return "Cut"
        case .selectAll: return "Select All"
        case .eraseWord: return "Erase Word"
        case .eraseLine: return "Erase Line"
        case .cursorLeft: return "Move Cursor Left"
        case .cursorRight: return "Move Cursor Right"
        }
    }
}
