//
//  MainMenu.swift
//  Scripty
//
//  Created by Ivan Smetanin on 18/03/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import Cocoa

final class MainMenu: NSMenu {

    // MARK: - Properties

    private var dataDisplayManager: MainMenuDataDisplayManager?
    private var windowController: NSWindowController?

    // MARK: - NSMenu

    override func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {
        return true
    }

    // MARK: - Internal methods

    func setupInitialState() {
        Notifications.shared.scriptsListChanged.addListner { [weak self] in
            self?.reloadData()
        }
        reloadData()
    }

    // MARK: - Private methods

    private func reloadData() {
        // retrieve commands
        let scriptsService = ScriptsService()
        let scripts = scriptsService.getAll()
        // configure ddm
        dataDisplayManager = MainMenuDataDisplayManager(menu: self)
        dataDisplayManager?.configure(with: scripts)
        dataDisplayManager?.addEvent += self.showAddScript

        dataDisplayManager?.quitEvent += { [weak self] in
            self?.quit()
        }
        dataDisplayManager?.scriptSelectionEvent += { [weak self] script in
            let runResult = Shell.run(script.args)
            self?.handleShellRun(result: runResult)
        }
    }

    private func handleShellRun(result: Shell.RunResult) {
        switch result {
        case .success:
            break
        case .error:
            showShellRunError()
        }
    }

    private func showShellRunError() {
        let alert = NSAlert()
        alert.messageText = L10n.Error.Shellrun.title
        alert.informativeText = L10n.Error.Shellrun.description
        alert.alertStyle = .warning
        alert.runModal()
    }

    private func showAddScript() {
        if self.windowController == nil {
            let windowController = NSStoryboard(
                name: String(describing: AddScriptViewController.self), bundle: nil
            ).instantiateController(
                withIdentifier: String(describing: AddScriptViewController.self)
            ) as? NSWindowController
            self.windowController = windowController
        }
        windowController?.showWindow(self)
        windowController?.window?.center()
        // move to front
        NSApp.activate(ignoringOtherApps: true)
    }

    private func quit() {
        NSApplication.shared.terminate(self)
    }

}
