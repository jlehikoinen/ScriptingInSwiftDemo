#!/usr/bin/swift

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {

    let appName = "Demo App"
    
    // UI elements
    let window = NSWindow(contentRect: NSMakeRect(0, 0, 600, 400),
                          styleMask: .titled,
                          backing: .buffered,
                          defer: true)
    
    // Methods
    func setupUI() {
        
        // Menu
        setupMenu(appName: appName)

        // Window
        setupWindow()
        
        // "Normal" window presence (activation & exit)
        window.orderFrontRegardless()
        NSApp.activate(ignoringOtherApps: true)
        
        // Setup window's content view
        // let contentView = window.contentView!

        // Dock icon
        setupDockIcon(path: "/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/GenericApplicationIcon.icns")
    }

    // Helper methods
    func setupMenu(appName: String) {
        
        let mainMenu = NSMenu()
        let menuItem = mainMenu.addItem(withTitle: "Application", action: nil, keyEquivalent: "")
        let subMenu = NSMenu()
        let titleQuit = NSLocalizedString("Quit", comment: "Quit menu item") + " " + appName
        let menuItemQuit = subMenu.addItem(withTitle: titleQuit, action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q")
        menuItemQuit.target = NSApp
        mainMenu.setSubmenu(subMenu, for: menuItem)
        NSApp.mainMenu = mainMenu
    }
    
    func setupWindow() {
        
        window.center()
        window.styleMask.insert(.closable)
        window.styleMask.insert(.miniaturizable)
        window.styleMask.insert(.resizable)
        window.backgroundColor = NSColor.controlBackgroundColor
        window.title = "Window"
    }
    
    func setupDockIcon(path: String) {
        
        let icon = NSImage(byReferencingFile: path)!
        icon.size = CGSize(width: 128, height: 128)
        NSApp.applicationIconImage = icon
    }
    
    // Required app delegate method
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        setupUI()
    }
}

// Setup app delegate and run the app
let thisApp = NSApplication.shared
NSApp.setActivationPolicy(.regular)
let appDelegate = AppDelegate()
thisApp.delegate = appDelegate
thisApp.run()
