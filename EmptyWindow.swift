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
    }
    
    // Helper methods
    func makeAWindow(width: CGFloat, height: CGFloat) -> NSWindow {
        
        let window = NSWindow(contentRect: NSMakeRect(0, 0, width, height),
                              styleMask: .titled,
                              backing: .buffered,
                              defer: true)
        window.center()
        window.styleMask.insert(.closable)
        window.styleMask.insert(.miniaturizable)
        window.styleMask.insert(.resizable)
        return window
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
