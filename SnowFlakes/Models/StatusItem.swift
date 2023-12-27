import AppKit

final class StatusItem: ObservableObject {
    private var popover: NSPopover?
    private var statusBarItem: NSStatusItem?

    func setup(contentVC: NSViewController) {
        statusBarItem = createStatusItem()
        popover = createPopover(contentVC: contentVC)
    }

    private func createStatusItem() -> NSStatusItem {
        let statusItemLength = NSStatusItem.squareLength
        let statusItemImage = NSImage(named: "Menu Flake")

        let statusBarItem = NSStatusBar.system.statusItem(withLength: statusItemLength)
        statusBarItem.button?.target = self
        statusBarItem.button?.action = #selector(self.togglePopover(_:))
        statusBarItem.button?.image = statusItemImage
        return statusBarItem
    }

    private func createPopover(contentVC: NSViewController) -> NSPopover {
        let popoverSize = contentVC.preferredContentSize

        let popover = NSPopover()
        popover.contentSize = popoverSize
        popover.behavior = .transient
        popover.contentViewController = contentVC
        return popover
    }

    @objc
    private func togglePopover(_ sender: AnyObject) {
        guard let button = statusBarItem?.button, let popover else {
            return
        }

        if popover.isShown {
            popover.performClose(sender)
        } else {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            // give popover focus
            popover.contentViewController?.view.window?.makeKey()
        }
    }
}
