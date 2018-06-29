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

        let mainAppIdentifier = "tech.buildy.Scripty"
        let runningApps = NSWorkspace.shared.runningApplications
        let isRunning = !runningApps.filter { $0.bundleIdentifier == mainAppIdentifier }.isEmpty

        if !isRunning {
            DistributedNotificationCenter.default().addObserver(
                self,
                selector: #selector(self.terminate),
                name: .killLauncher,
                object: mainAppIdentifier
            )

            let path = Bundle.main.bundlePath as NSString
            var components = path.pathComponents
            components.removeLast()
            components.removeLast()
            components.removeLast()
            components.append("MacOS")
            components.append("Scripty")

            let newPath = NSString.path(withComponents: components)

            NSWorkspace.shared.launchApplication(newPath)
        } else {
            self.terminate()
        }
    }

    // MARK: - Private methods

    @objc
    private func terminate() {
        NSApp.terminate(nil)
    }

}

