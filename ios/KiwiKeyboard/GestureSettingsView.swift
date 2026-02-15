import SwiftUI

struct GestureSettingsView: View {
    @State private var config = GestureConfig.load()

    var body: some View {
        List {
            Section(header: Text("Right Half Gestures")) {
                gestureRow(.rightSwipeUp)
                gestureRow(.rightSwipeDown)
                gestureRow(.rightSwipeLeft)
                gestureRow(.rightSwipeRight)
            }

            Section(header: Text("Left Half Gestures")) {
                gestureRow(.leftSwipeUp)
                gestureRow(.leftSwipeDown)
                gestureRow(.leftSwipeLeft)
                gestureRow(.leftSwipeRight)
            }
        }
        .navigationTitle("Gesture Shortcuts")
        .onAppear {
            config = GestureConfig.load()
        }
    }

    private func gestureRow(_ gesture: SwipeGesture) -> some View {
        let binding = Binding<GestureAction>(
            get: { config.action(for: gesture) },
            set: { newValue in
                config.setAction(newValue, for: gesture)
                config.save()
            }
        )

        return HStack {
            VStack(alignment: .leading) {
                Text(gesture.displayName)
                    .font(.body)
            }
            Spacer()
            Picker("", selection: binding) {
                ForEach(GestureAction.allCases) { action in
                    Text(action.displayName).tag(action)
                }
            }
            .pickerStyle(.menu)
        }
    }
}
