import UIKit

class GestureActionExecutor {
    weak var viewController: UIInputViewController?

    var textDocumentProxy: UITextDocumentProxy? {
        viewController?.textDocumentProxy
    }

    init(viewController: UIInputViewController) {
        self.viewController = viewController
    }

    func execute(_ action: GestureAction) {
        guard let proxy = textDocumentProxy else { return }

        switch action {
        case .none:
            break

        case .undo:
            viewController?.undoManager?.undo()

        case .redo:
            viewController?.undoManager?.redo()

        case .paste:
            if let text = UIPasteboard.general.string {
                proxy.insertText(text)
            }

        case .copy:
            // Copy requires text selection which keyboard extensions cannot access.
            // This is a no-op in the keyboard context.
            break

        case .cut:
            // Cut requires text selection which keyboard extensions cannot access.
            // This is a no-op in the keyboard context.
            break

        case .selectAll:
            // SelectAll cannot be triggered from a keyboard extension.
            // This is a no-op in the keyboard context.
            break

        case .eraseWord:
            deleteBackwardToWordBoundary(proxy: proxy)

        case .eraseLine:
            deleteBackwardToLineBoundary(proxy: proxy)

        case .cursorLeft:
            proxy.adjustTextPosition(byCharacterOffset: -1)

        case .cursorRight:
            proxy.adjustTextPosition(byCharacterOffset: 1)
        }
    }

    private func deleteBackwardToWordBoundary(proxy: UITextDocumentProxy) {
        guard let text = proxy.documentContextBeforeInput, !text.isEmpty else { return }

        var count = 0
        let reversed = Array(text.reversed())

        var i = 0
        while i < reversed.count && reversed[i].isWhitespace {
            i += 1
            count += 1
        }

        while i < reversed.count && !reversed[i].isWhitespace {
            i += 1
            count += 1
        }

        for _ in 0..<count {
            proxy.deleteBackward()
        }
    }

    private func deleteBackwardToLineBoundary(proxy: UITextDocumentProxy) {
        guard let text = proxy.documentContextBeforeInput, !text.isEmpty else { return }

        var count = 0
        for char in text.reversed() {
            if char == "\n" { break }
            count += 1
        }

        for _ in 0..<count {
            proxy.deleteBackward()
        }
    }
}
