#!/usr/bin/swift

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {

    var mainWindow: NSWindow?
    let appName = "Demo App"
    
    func setupUIProperties() {
        
        // Menu
        makeAMenu(appName: appName)

        // Window
        let appWindow = makeAWindow(width: 480, height: 270)
        
        // "Normal" window presence (activation & exit)
        appWindow.orderFrontRegardless()
        self.mainWindow = appWindow
        NSApp.activate(ignoringOtherApps: true)

        // Dock icon
        makeADockIcon(path: "/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/GenericApplicationIcon.icns")
    }

    // Helper methods
    func makeAMenu(appName: String) {

        let mainMenu = NSMenu()
        let menuItem = mainMenu.addItem(withTitle:"Application", action:nil, keyEquivalent:"")
        let subMenu = NSMenu()
        let titleQuit = NSLocalizedString("Quit", comment:"Quit menu item") + " " + appName
        let menuItemQuit = subMenu.addItem(withTitle: titleQuit, action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q")
        menuItemQuit.target = NSApp
        mainMenu.setSubmenu(subMenu, for: menuItem)
        NSApp.mainMenu = mainMenu
    }

    func makeADockIcon(path: String) {

        let icon = NSImage(byReferencingFile: path)!
        icon.size = CGSize(width: 128, height: 128)
        NSApp.applicationIconImage = icon
    }

    func makeAWindow(width: CGFloat, height: CGFloat) -> NSWindow {
        
        let window = NSWindow(contentRect: NSMakeRect(0, 0, width, height),
                              styleMask: .titled,
                              backing: .buffered,
                              defer: true)
        window.center()
        window.styleMask.insert(.closable)
        window.styleMask.insert(.miniaturizable)
        window.styleMask.insert(.resizable)
        window.title = "Window"
        return window
    }
    
    // Required app delegate method
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        setupUIProperties()
    }
    
    // Close app when toolbar red button is pushed
    func applicationShouldTerminateAfterLastWindowClosed(_ app: NSApplication) -> Bool {
        return true
    }
}

// Setup app delegate and run the app
let thisApp = NSApplication.shared
NSApp.setActivationPolicy(.regular)
let appDelegate = AppDelegate()
thisApp.delegate = appDelegate
thisApp.run()
