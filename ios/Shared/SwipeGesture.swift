import Foundation

enum SwipeGesture: String, Codable, CaseIterable, Identifiable {
    case rightSwipeUp
    case rightSwipeDown
    case rightSwipeLeft
    case rightSwipeRight
    case leftSwipeUp
    case leftSwipeDown
    case leftSwipeLeft
    case leftSwipeRight

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .rightSwipeUp: return "Right Half \u{2014} Swipe Up"
        case .rightSwipeDown: return "Right Half \u{2014} Swipe Down"
        case .rightSwipeLeft: return "Right Half \u{2014} Swipe Left"
        case .rightSwipeRight: return "Right Half \u{2014} Swipe Right"
        case .leftSwipeUp: return "Left Half \u{2014} Swipe Up"
        case .leftSwipeDown: return "Left Half \u{2014} Swipe Down"
        case .leftSwipeLeft: return "Left Half \u{2014} Swipe Left"
        case .leftSwipeRight: return "Left Half \u{2014} Swipe Right"
        }
    }
}
