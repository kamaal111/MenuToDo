//
//  AppDelegate.swift
//  MenuToDo
//
//  Created by Kamaal M Farah on 27/06/2022.
//

import SwiftUI

final class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject {

    private var statusItem: NSStatusItem!
    private var popover: NSPopover!
    private var theme = Theme()

    func applicationDidFinishLaunching(_ notification: Notification) {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

        if let statusButton = statusItem.button {
            statusButton.image = theme.menubarIcon.nsImage
            statusButton.action = #selector(togglePopover)
        }

        popover = NSPopover()

        popover.contentSize = NSSize(width: Constants.UI.popoverSize.width, height: Constants.UI.popoverSize.height)
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(rootView: view())
    }

    private func view() -> some View {
        ContentView()
            .environmentObject(theme)
    }

    @objc
    private func togglePopover(_ button: NSStatusBarButton) {
        if popover.isShown {
            popover.performClose(nil)
        } else {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
    }

}
