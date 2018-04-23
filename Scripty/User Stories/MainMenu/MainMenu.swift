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

    // MARK: - NSMenu

    override func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {
        return true
    }

    // MARK: - Internal methods

    func setupInitialState() {
        Notifications.shared.commandsListChanged.addListner { [weak self] in
            self?.reloadData()
        }
        reloadData()
    }

    // MARK: - Private methods

    private func reloadData() {
        // retrieve commands
        let commandsService = CommandsService()
        let commands = commandsService.getAll()
        // configure ddm
        dataDisplayManager = MainMenuDataDisplayManager(menu: self)
        dataDisplayManager?.configure(with: commands)
        dataDisplayManager?.addEvent += {
            let windowController = NSStoryboard(name: String(describing: AddScriptViewController.self), bundle: nil)
                .instantiateController(withIdentifier: String(describing: AddScriptViewController.self)) as? NSWindowController
            windowController?.showWindow(self)
        }
        dataDisplayManager?.quitEvent += {
            NSApplication.shared.terminate(self)
        }
        dataDisplayManager?.commandSelectionEvent += { command in
            Shell.run(command.args)
        }
    }

}
