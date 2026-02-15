import SwiftUI

struct SwipeGestureModifier: ViewModifier {
    let onSwipe: (SwipeGesture) -> Void
    let onSwipeStarted: () -> Void

    @State private var viewWidth: CGFloat = 0
    @State private var isSwiping = false

    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geo in
                    Color.clear
                        .onAppear { viewWidth = geo.size.width }
                        .onChange(of: geo.size.width) { viewWidth = $0 }
                }
            )
            .simultaneousGesture(
                DragGesture(minimumDistance: 50)
                    .onChanged { _ in
                        if !isSwiping {
                            isSwiping = true
                            onSwipeStarted()
                        }
                    }
                    .onEnded { value in
                        defer { isSwiping = false }

                        let dx = value.translation.width
                        let dy = value.translation.height

                        guard sqrt(dx * dx + dy * dy) >= 50 else { return }

                        let isRightHalf = value.startLocation.x >= viewWidth / 2

                        let gesture: SwipeGesture
                        if abs(dx) > abs(dy) {
                            gesture = isRightHalf
                                ? (dx > 0 ? .rightSwipeRight : .rightSwipeLeft)
                                : (dx > 0 ? .leftSwipeRight : .leftSwipeLeft)
                        } else {
                            gesture = isRightHalf
                                ? (dy > 0 ? .rightSwipeDown : .rightSwipeUp)
                                : (dy > 0 ? .leftSwipeDown : .leftSwipeUp)
                        }

                        onSwipe(gesture)
                    }
            )
    }
}
