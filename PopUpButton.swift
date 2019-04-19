#!/usr/bin/swift

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {

    let appName = "Demo App"
    
    // UI elements
    let window = NSWindow(contentRect: NSMakeRect(0, 0, 600, 400),
                          styleMask: .titled,
                          backing: .buffered,
                          defer: true)
    let label = NSTextField(frame: NSRect(x: 0, y: 300, width: 600, height: 60))
    let popUpButton = NSPopUpButton(frame: NSRect(x: 240, y: 150, width: 120, height: 60))
    
    // Methods
    func setupUIProperties() {
        
        // Menu
        setupMenu(appName: appName)
        
        // Window
        setupWindow()
        
        // "Normal" window presence (activation & exit)
        window.orderFrontRegardless()
        NSApp.activate(ignoringOtherApps: true)
        
        // Setup window's content view
        let contentView = window.contentView!
        
        // Dock icon
        setupDockIcon(path: "/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/GenericApplicationIcon.icns")
        
        ///////////////
        
        // Popup button
        setupPopUpButton()
        contentView.addSubview(popUpButton)
        popUpButton.action = #selector(popUpButtonClicked)
        
        // Label
        setupLabel()
        contentView.addSubview(label)
    }
    
    // Button actions
    @objc func popUpButtonClicked(sender: AnyObject) {
        
        let optionSelected = popUpButton.titleOfSelectedItem!
        print("\(optionSelected) selected")
        label.stringValue = optionSelected
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
    
    func setupLabel() {
        
        label.isBezeled = false
        label.isEditable = false
        label.font = NSFont.systemFont(ofSize: 40)
        label.alignment = .center
    }
    
    func setupPopUpButton() {
        
        popUpButton.addItem(withTitle: "Earth")
        popUpButton.addItem(withTitle: "Wind")
        popUpButton.addItem(withTitle: "Fire")
    }
    
    // Required app delegate method
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        setupUIProperties()
    }
}

// Setup app delegate and run the app
let thisApp = NSApplication.shared
NSApp.setActivationPolicy(.regular)
let appDelegate = AppDelegate()
thisApp.delegate = appDelegate
thisApp.run()
