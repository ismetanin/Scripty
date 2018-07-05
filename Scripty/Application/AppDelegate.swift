//
//  AppDelegate.swift
//  Scripty
//
//  Created by Ivan Smetanin on 18/03/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    // MARK: - IBOutlets

    @IBOutlet private weak var statusMenu: MainMenu!

    // MARK: - Constants

    private let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

    // MARK: - NSApplicationDelegate

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem.image = #imageLiteral(resourceName: "imgStatusItemIcon")
        statusItem.highlightMode = true
        statusItem.menu = statusMenu
        statusMenu.setupInitialState()
        NSApplication.shared.shouldLaunchOnStartup = true
    }

}
