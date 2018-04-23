//
//  MainMenuDataDisplayManager.swift
//  Scripty
//
//  Created by Ivan Smetanin on 18/03/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import Cocoa

final class MainMenuDataDisplayManager {

    // MARK: - Constants

    private let menu: NSMenu

    // MARK: - Properties

    private var commands: [Command] = []
    var addEvent: BaseEvent<Void> = BaseEvent<Void>()
    var commandSelectionEvent: BaseEvent<Command> = BaseEvent<Command>()
    var quitEvent: BaseEvent<Void> = BaseEvent<Void>()

    // MARK: - Initialization and deinitialization

    init(menu: NSMenu) {
        self.menu = menu
    }

    // MARK: - Internal methods

    func configure(with commands: [Command]) {
        menu.removeAllItems()

        self.commands = commands

        // add command item
        let addItem = NSMenuItem(title: L10n.Mainmenu.addItemTitle, action: #selector(add(_:)), keyEquivalent: "")
        addItem.target = self
        menu.addItem(addItem)

        // separator
        menu.addItem(NSMenuItem.separator())

        // commands
        for (index, command) in commands.enumerated() {
            let item = NSMenuItem(title: command.name, action: #selector(shellAction(for:)), keyEquivalent: "")
            item.target = self
            item.tag = index
            menu.addItem(item)
        }

        // separator
        menu.addItem(NSMenuItem.separator())

        // quit item
        let quitItem = NSMenuItem(title: L10n.Mainmenu.quitItemTitle, action: #selector(quitAction(_:)), keyEquivalent: "")
        quitItem.target = self
        menu.addItem(quitItem)
    }

}

// MARK: - Private methods

private extension MainMenuDataDisplayManager {


    @objc
    private func add(_ sender: NSMenuItem) {
        addEvent.invoke(with: ())
    }

    @objc
    private func shellAction(for item: NSMenuItem) {
        let command = commands[item.tag]
        commandSelectionEvent.invoke(with: command)
    }

    @objc
    private func quitAction(_ sender: NSMenuItem) {
        quitEvent.invoke(with: ())
    }

}
