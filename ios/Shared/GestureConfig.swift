import Foundation

struct GestureConfig: Codable {
    var mappings: [String: String]

    static let suiteName = "group.com.kiwi.keyboard"
    static let storeKey = "gestureConfig"

    static var `default`: GestureConfig {
        var config = GestureConfig(mappings: [:])
        for gesture in SwipeGesture.allCases {
            config.mappings[gesture.rawValue] = GestureAction.none.rawValue
        }
        config.mappings[SwipeGesture.rightSwipeLeft.rawValue] = GestureAction.eraseWord.rawValue
        config.mappings[SwipeGesture.rightSwipeDown.rawValue] = GestureAction.paste.rawValue
        return config
    }

    func action(for gesture: SwipeGesture) -> GestureAction {
        guard let raw = mappings[gesture.rawValue],
              let action = GestureAction(rawValue: raw) else {
            return .none
        }
        return action
    }

    mutating func setAction(_ action: GestureAction, for gesture: SwipeGesture) {
        mappings[gesture.rawValue] = action.rawValue
    }

    func save() {
        guard let defaults = UserDefaults(suiteName: GestureConfig.suiteName) else {
            print("[GestureConfig] Failed to access App Group UserDefaults — check entitlements")
            return
        }
        do {
            let data = try JSONEncoder().encode(self)
            defaults.set(data, forKey: GestureConfig.storeKey)
        } catch {
            print("[GestureConfig] Failed to encode config: \(error)")
        }
    }

    static func load() -> GestureConfig {
        guard let defaults = UserDefaults(suiteName: suiteName) else {
            print("[GestureConfig] Failed to access App Group UserDefaults — check entitlements")
            return .default
        }
        guard let data = defaults.data(forKey: storeKey) else {
            return .default
        }
        do {
            return try JSONDecoder().decode(GestureConfig.self, from: data)
        } catch {
            print("[GestureConfig] Failed to decode config: \(error)")
            return .default
        }
    }
}
