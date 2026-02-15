import UIKit
import KeyboardKit
import SwiftUI

class KeyboardViewController: KeyboardInputViewController {

    private lazy var executor = GestureActionExecutor(viewController: self)
    private var config = GestureConfig.load()

    override func viewWillSetupKeyboardView() {
        super.viewWillSetupKeyboardView()
        setupKeyboardView { [weak self] controller in
            KeyboardView(
                state: controller.state,
                services: controller.services,
                buttonContent: { $0.view },
                buttonView: { $0.view },
                emojiKeyboard: { $0.view },
                toolbar: { $0.view }
            )
            .modifier(SwipeGestureModifier(
                onSwipe: { gesture in
                    guard let self = self else { return }
                    let action = self.config.action(for: gesture)
                    self.executor.execute(action)
                },
                onSwipeStarted: {
                    // Dismiss the key callout popup during a swipe
                    self?.state.calloutContext.inputContext.reset()
                }
            ))
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        config = GestureConfig.load()
    }
}
