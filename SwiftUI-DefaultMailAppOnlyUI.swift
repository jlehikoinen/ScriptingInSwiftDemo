#!/usr/bin/swift

import Cocoa
import SwiftUI

struct ContentView: View {
    
    @State private var mailButtonClicked = false
    @State private var outlookButtonClicked = false
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Choose default email app")
                .font(.title)
            HStack {
                Spacer()
                    .frame(width: 120)
                ZStack {
                    Image(nsImage: NSWorkspace.shared.icon(forFile: "/System/Applications/Mail.app"))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80.0, height: 80.0)
                    if mailButtonClicked {
                        Text("⭐️")
                            .font(.title)
                            .offset(x: 30, y: 30)
                    }
                }
                Spacer()
                Button(action: {
                    print("macOS Mail selected")
                    mailButtonClicked = true
                    outlookButtonClicked = false
                }) {
                    Text("macOS Mail")
                        // .frame(width: 200, height: 60)
                        // .foregroundColor(Color.white)
                        // .background(Color.gray)
                        // .cornerRadius(5)
                }
                Spacer()
            }
            HStack {
                Spacer()
                    .frame(width: 120)
                ZStack {
                    Image(nsImage: NSWorkspace.shared.icon(forFile: "/Applications/Microsoft Outlook.app"))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80.0, height: 80.0)
                    if outlookButtonClicked {
                        Text("⭐️")
                            .font(.title)
                            .offset(x: 30, y: 30)
                    }
                }
                Spacer()
                Button(action: {
                    print("Outlook selected")
                    mailButtonClicked = false
                    outlookButtonClicked = true
                }) {
                    Text("Outlook")
                }
                Spacer()
            }
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    
    let appName = "Demo App"
    
    // Window
    let window = NSWindow(contentRect: NSMakeRect(0, 0, 600, .zero),
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
        
        // Setup window's SwiftUI content view
        window.contentView = NSHostingView(rootView: ContentView().padding(30))
        
        // Dock icon
        setupDockIcon(path: "/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/ToolbarCustomizeIcon.icns")
    }
    
    // Helper methods
    func setupMenu(appName: String) {
        
        let mainMenu = NSMenu()
        let subMenu = NSMenu()
        let menuItem = mainMenu.addItem(withTitle: "Application", action: nil, keyEquivalent: "")
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
        window.backgroundColor = NSColor.controlBackgroundColor
        window.title = appName
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
