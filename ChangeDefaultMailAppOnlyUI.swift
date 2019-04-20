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
    let mailView = NSImageView(frame: NSRect(x: 120, y: 200, width: 80, height: 80))
    let outlookView = NSImageView(frame: NSRect(x: 120, y: 80, width: 80, height: 80))
    let mailButton = NSButton(frame: NSRect(x: 280, y: 210, width: 200, height: 60))
    let outlookButton = NSButton(frame: NSRect(x: 280, y: 90, width: 200, height: 60))
    
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
        let contentView = window.contentView!
        
        // Dock icon
        setupDockIcon(path: "/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/ToolbarCustomizeIcon.icns")
        
        ///////////////
        
        // Label
        setupLabel(title: "Choose default email app")
        contentView.addSubview(label)

        // Icons
        setupIcon(appPath: "/Applications/Mail.app", imageView: mailView)
        contentView.addSubview(mailView)
        
        setupIcon(appPath: "/Applications/Microsoft Outlook.app", imageView: outlookView)
        contentView.addSubview(outlookView)
        
        // Buttons
        setupButton(title: "macOS Mail", button: mailButton)
        contentView.addSubview(mailButton)
        mailButton.action = #selector(mailButtonClicked)
        
        setupButton(title: "Outlook", button: outlookButton)
        contentView.addSubview(outlookButton)
        outlookButton.action = #selector(outlookButtonClicked)
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
        window.title = appName
    }
    
    func setupDockIcon(path: String) {
        
        let icon = NSImage(byReferencingFile: path)!
        icon.size = CGSize(width: 128, height: 128)
        NSApp.applicationIconImage = icon
    }
    
    func setupLabel(title: String) {
        
        label.isBezeled = false
        label.isEditable = false
        label.font = NSFont.systemFont(ofSize: 40)
        label.alignment = .center
        label.stringValue = title
    }
    
    func setupIcon(appPath: String, imageView: NSImageView) {
        
        let appIcon: NSImage = NSWorkspace.shared.icon(forFile: appPath)
        appIcon.size = NSSize(width: 80.0, height: 80.0)
        imageView.image = appIcon
    }

    func setupButton(title: String, button: NSButton) {

        button.bezelStyle = .regularSquare
        button.font = NSFont.systemFont(ofSize: 20)
        button.title = title
    }
    
    // Button actions
    @objc func mailButtonClicked(sender: AnyObject) {

        print("macOS Mail selected")
    }
    
    @objc func outlookButtonClicked(sender: AnyObject) {

        print("Outlook selected")
    }
    
    // Required app delegate method
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        setupUI()
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