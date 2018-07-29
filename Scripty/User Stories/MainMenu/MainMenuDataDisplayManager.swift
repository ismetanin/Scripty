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

    private var scripts: [Script] = []
    var addEvent: BaseEvent<Void> = BaseEvent<Void>()
    var scriptSelectionEvent: BaseEvent<Script> = BaseEvent<Script>()
    var quitEvent: BaseEvent<Void> = BaseEvent<Void>()

    // MARK: - Initialization and deinitialization

    init(menu: NSMenu) {
        self.menu = menu
    }

    // MARK: - Internal methods

    func configure(with scripts: [Script]) {
        menu.removeAllItems()

        self.scripts = scripts

        // add command item
        let addItem = NSMenuItem(title: L10n.Mainmenu.addItemTitle, action: #selector(add(_:)), keyEquivalent: "")
        addItem.target = self
        menu.addItem(addItem)

        // separator
        menu.addItem(NSMenuItem.separator())

        // commands
        for (index, script) in scripts.enumerated() {
            let item = NSMenuItem(title: script.name, action: #selector(shellAction(for:)), keyEquivalent: "")
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
        let script = scripts[item.tag]
        scriptSelectionEvent.invoke(with: script)
    }

    @objc
    private func quitAction(_ sender: NSMenuItem) {
        quitEvent.invoke(with: ())
    }

}
