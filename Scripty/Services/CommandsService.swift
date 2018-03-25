//
//  CommandsService.swift
//  Scripty
//
//  Created by Ivan Smetanin on 18/03/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import Foundation

final class CommandsService {

    // MARK: - Properties

    private var commands: [Command] = [Command(name: "Open Safari", args: ["open", "-a", "safari"]),
                                       Command(name: "Open Telegram", args: ["open", "-a", "telegram"]),
                                       Command(name: "Delete derrived data", args: ["rm -rf"])
                                       ]

    // MARK: - Internal methods

    func add(command: Command) {
        commands.append(command)
    }

    func getAll() -> [Command] {
        return commands
    }

}
