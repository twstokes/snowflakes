import AppKit

/// An OverlayWindow covers the entire screen with a transparent view that is non-interactive, non-focusable, and always showing.

class OverlayWindow: NSPanel {
    convenience init(screen: NSScreen, stayOnTop: Bool = false) {
        let contentRect = NSRect(origin: .zero, size: screen.frame.size)
        self.init(contentRect: contentRect, styleMask: .nonactivatingPanel, backing: .buffered, defer: false, screen: screen)

        isOpaque = false
        hasShadow = false
        backgroundColor = .clear
        ignoresMouseEvents = true
        collectionBehavior = [.stationary, .canJoinAllSpaces, .ignoresCycle]

        if stayOnTop {
            // Side effect: The OverlayWindow will capture any attempts to screenshot at the window-level.
            // It would be better if it didn't respond to window screenshot requests at all.
            let shieldingLevel = CGShieldingWindowLevel()
            level = .init(Int(shieldingLevel))
            collectionBehavior.insert(.fullScreenAuxiliary)
        } else {
            level = NSWindow.Level(rawValue: NSWindow.Level.normal.rawValue - 1)
            collectionBehavior.insert(.fullScreenNone)
        }
    }
}
