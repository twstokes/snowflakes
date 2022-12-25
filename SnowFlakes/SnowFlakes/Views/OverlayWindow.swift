import AppKit

/// An OverlayWindow covers the entire screen with a transparent view that is non-interactive, non-focusable, and always showing.

/// Side effect: The OverlayWindow will capture any attempts to screenshot at the window-level. It would be better if it didn't respond to window screenshot requests at all.
class OverlayWindow: NSPanel {
    convenience init(screen: NSScreen) {
        let contentRect = NSRect(origin: .zero, size: screen.frame.size)
        self.init(contentRect: contentRect, styleMask: .nonactivatingPanel, backing: .buffered, defer: false, screen: screen)
        
        isOpaque = false
        hasShadow = false
        backgroundColor = .clear
        ignoresMouseEvents = true

        // don't interact with Exposé, exist on all Spaces
        collectionBehavior = [.stationary, .canJoinAllSpaces, .fullScreenAuxiliary]


        // TODO - feature to choose the level - over everything (shielding level) or something like base level (can't bring to foreground, only desktop background)
        // note: if init(0) (baseWindow) level, we may need to tell it to not come to the foreground initially - this way it stays in the background.

        // check out CGWindowLevelKey for ideas
        // keep the window above everything at all times
        let shieldingLevel = CGShieldingWindowLevel()
        level = .init(Int(shieldingLevel))
//        level = .init(0)
    }
}
