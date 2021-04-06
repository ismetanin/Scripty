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

    func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {
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
        case .success(let output):
            showAlert(title: L10n.ShellRun.Success.title, message: output)
        case .error(let output):
            showAlert(title: L10n.ShellRun.Error.title, message: output.isEmpty ? L10n.ShellRun.Error.description : output)
        }
    }

    private func showAlert(title: String, message: String) {
        let alert = NSAlert()
        alert.messageText = title
        alert.informativeText = message
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
