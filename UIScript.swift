#!/usr/bin/swift

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    
    var mainWindow: NSWindow?
    
    func setupUIProperties() {
        
        // Window
        let appWindow = makeAWindow(width: 600, height: 400)
        
        // "Normal" window presence (activation & exit)
        appWindow.orderFrontRegardless()
        self.mainWindow = appWindow
        NSApp.activate(ignoringOtherApps: true)
        
        // Setup window's content view
        let contentView = appWindow.contentView!
        
        // Dock icon
        makeADockIcon(path: "/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/ToolbarCustomizeIcon.icns")
        
        // Header
        let mainLabel = makeALabel(title: "Choose default email app", xCoord: 0, yCoord: 300)
        contentView.addSubview(mainLabel)
        
        // Icons
        let mailView = makeAnIcon(appPath: "/Applications/Mail.app", xCoord: 120, yCoord: 200)
        contentView.addSubview(mailView)
        let outlookView = makeAnIcon(appPath: "/Applications/Microsoft Outlook.app", xCoord: 120, yCoord: 80)
        contentView.addSubview(outlookView)
        
        // Buttons
        let mailButton = makeAButton(title: "macOS Mail", xCoord: 280, yCoord: 210)
        contentView.addSubview(mailButton)
        mailButton.action = #selector(mailButtonClicked)
        let outlookButton = makeAButton(title: "Outlook", xCoord: 280, yCoord: 90)
        contentView.addSubview(outlookButton)
        outlookButton.action = #selector(outlookButtonClicked)
    }
    
    // Helper methods
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
        window.styleMask.insert(.unifiedTitleAndToolbar)
        window.backgroundColor = NSColor.controlBackgroundColor
        window.toolbar?.isVisible = false
        window.titlebarAppearsTransparent = true
        return window
    }
    
    func makeALabel(title: String, xCoord: Int, yCoord: Int) -> NSTextField {
        
        let label = NSTextField(frame: NSRect(x: xCoord, y: yCoord, width: 600, height: 80))
        label.isBezeled = false
        label.drawsBackground = false
        label.isBordered = false
        label.isEditable = false
        label.font = NSFont.systemFont(ofSize: 40)
        label.alignment = .center
        label.stringValue = title
        return label
    }
    
    func makeAnIcon(appPath: String, xCoord: Int, yCoord: Int) -> NSView {
        
        let appIcon: NSImage = NSWorkspace.shared.icon(forFile: appPath)
        appIcon.size = NSSize(width: 80.0, height: 80.0)
        let imageView = NSImageView(frame: NSRect(x: xCoord, y: yCoord, width: 80, height: 80))
        imageView.image = appIcon
        return imageView
    }
    
    func makeAButton(title: String, xCoord: Int, yCoord: Int) -> NSButton {
        
        let button = NSButton(frame: NSRect(x: xCoord, y: yCoord, width: 200, height: 60))
        button.bezelStyle = .regularSquare
        button.font = NSFont.systemFont(ofSize: 20)
        button.title = title
        return button
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
        
        setupUIProperties()
    }
    
    // Exit when red button is pushed
    func applicationShouldTerminateAfterLastWindowClosed(_ app: NSApplication) -> Bool {
        return true
    }
}

// "Create" the app
let thisApp = NSApplication.shared
NSApp.setActivationPolicy(.regular)
let appDelegate = AppDelegate()
thisApp.delegate = appDelegate
thisApp.run()
