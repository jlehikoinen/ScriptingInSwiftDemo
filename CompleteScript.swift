#!/usr/bin/swift

import Cocoa

struct DefaultApp {

    // Globals
    static let utiHandlerMicrosoft = [
        "com.apple.mail.email": "com.microsoft.outlook",
        "com.microsoft.outlook16.email-message": "com.microsoft.outlook",
        "public.vcard": "com.microsoft.outlook",
        "com.apple.ical.ics": "com.microsoft.outlook",
        "com.microsoft.outlook16.icalendar": "com.microsoft.outlook"
    ]
    
    static let utiHandlerApple = [
        "com.apple.mail.email": "com.apple.mail",
        "public.vcard": "com.apple.AddressBook",
        "com.apple.ical.ics": "com.apple.CalendarFileHandler",
    ]
    
    static let urlSchemeApple = ["mailto": "com.apple.mail"]
    static let urlSchemeMicrosoft = ["mailto": "com.microsoft.outlook"]
    
    // Funcs
    func getDefaultApp(handler: Dictionary<String, String>) {
        
        for (contentType, _) in handler {
            if let appHandler = LSCopyDefaultRoleHandlerForContentType(contentType as CFString, LSRolesMask.editor) {
                let bundleID = Unmanaged.fromOpaque(appHandler.toOpaque()).takeUnretainedValue() as CFString
                print("\(contentType): \(bundleID)")
            }
        }
    }
    
    func getDefaultScheme(handler: Dictionary<String, String>) {
        
        for (scheme, _) in handler {
            if let appScheme = LSCopyDefaultHandlerForURLScheme(scheme as CFString) {
                let bundleID = Unmanaged.fromOpaque(appScheme.toOpaque()).takeUnretainedValue() as CFString
                print("\(scheme): \(bundleID)")
            }
        }
    }
    
    func setDefaultApp(handler: Dictionary<String, String>) {
        for (contentType, lsHandler) in handler {
            LSSetDefaultRoleHandlerForContentType(contentType as CFString, LSRolesMask.editor, lsHandler as CFString)
        }
    }
    
    func setDefaultScheme(handler: Dictionary<String, String>) {
        for (scheme, lsHandler) in handler {
            LSSetDefaultHandlerForURLScheme(scheme as CFString, lsHandler as CFString)
        }
    }
}

/////////////////

class AppDelegate: NSObject, NSApplicationDelegate {
    
    var mainWindow: NSWindow?
    let defaultApp = DefaultApp()
    let appName = "Demo App"

    func setupUIProperties() {
        
        // Menu
        makeAMenu(appName: appName)

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

    // UI helper methods
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
        window.styleMask.insert(.unifiedTitleAndToolbar)
        window.backgroundColor = NSColor.controlBackgroundColor
        window.title = appName
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
        
//        print("Current settings:")
//        defaultApp.getDefaultApp(handler: DefaultApp.utiHandlerMicrosoft)
//        defaultApp.getDefaultScheme(handler: DefaultApp.urlSchemeMicrosoft)
        print("macOS Mail selected")
        defaultApp.setDefaultApp(handler: DefaultApp.utiHandlerApple)
        defaultApp.setDefaultScheme(handler: DefaultApp.urlSchemeApple)
    }

    @objc func outlookButtonClicked(sender: AnyObject) {

//        print("Current settings:")
//        defaultApp.getDefaultApp(handler: DefaultApp.utiHandlerMicrosoft)
//        defaultApp.getDefaultScheme(handler: DefaultApp.urlSchemeMicrosoft)
        print("Outlook selected")
        defaultApp.setDefaultApp(handler: DefaultApp.utiHandlerMicrosoft)
        defaultApp.setDefaultScheme(handler: DefaultApp.urlSchemeMicrosoft)
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
