import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                Section {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Setup Instructions")
                            .font(.headline)
                        Text("1. Open Settings \u{203A} General \u{203A} Keyboard \u{203A} Keyboards")
                        Text("2. Tap \"Add New Keyboard...\"")
                        Text("3. Select \"Kiwi\"")
                        Text("4. Tap \"Kiwi\" and enable \"Allow Full Access\"")
                    }
                    .padding(.vertical, 8)
                }

                Section {
                    NavigationLink("Gesture Shortcuts") {
                        GestureSettingsView()
                    }
                }
            }
            .navigationTitle("Kiwi Keyboard")
        }
    }
}
