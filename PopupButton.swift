#!/usr/bin/swift

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {

    var mainWindow: NSWindow?
    let appName = "Demo App"
    
    // Popup button
    let pop = NSPopUpButton(frame: NSRect(x: 180, y: 100, width: 120, height: 60))
    // Label
    let label = NSTextField(frame: NSRect(x: 0, y: 300, width: 600, height: 80))
    
    //
    func setupUIProperties() {
        
        // Menu
        makeAMenu(appName: appName)
        
        // "Normal" window presence (activation & exit)
        appWindow.orderFrontRegardless()
        self.mainWindow = appWindow
        NSApp.activate(ignoringOtherApps: true)

        // Dock icon
        makeADockIcon(path: "/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/GenericApplicationIcon.icns")
        
        // Setup window's content view
        let contentView = appWindow.contentView!
        
        // Configure popup button
        pop.addItem(withTitle: "Option 1")
        pop.addItem(withTitle: "Option 2")
        pop.addItem(withTitle: "Option 3")
        contentView.addSubview(pop)
        pop.action = #selector(popupButtonClicked)
        
        // Configure label
        label.isBezeled = false
        label.isEditable = false
        label.font = NSFont.systemFont(ofSize: 40)
        label.alignment = .center
    }
    
    // Button actions
    @objc func popupButtonClicked(sender: AnyObject) {
        
        let optionSelected = pop.titleOfSelectedItem!
        print("\(optionSelected) selected")
        label.stringValue = optionSelected
        let contentView = appWindow.contentView!
        contentView.addSubview(label)
    }
    
    // Update label
    
    
    func makeALabel(title: String, xCoord: Int, yCoord: Int) -> NSTextField {
        
        label.isBezeled = false
        label.isEditable = false
        label.font = NSFont.systemFont(ofSize: 40)
        label.alignment = .center
        label.stringValue = title
        return label
    }

    // Helper methods
    func makeAMenu(appName: String) {
        
        let mainMenu = NSMenu()
        let menuItem = mainMenu.addItem(withTitle: "Application", action: nil, keyEquivalent: "")
        let subMenu = NSMenu()
        let titleQuit = NSLocalizedString("Quit", comment: "Quit menu item") + " " + appName
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
}

// Setup app delegate and run the app
let thisApp = NSApplication.shared
NSApp.setActivationPolicy(.regular)
let appDelegate = AppDelegate()
thisApp.delegate = appDelegate
thisApp.run()
