//
//  CommandsService.swift
//  Scripty
//
//  Created by Ivan Smetanin on 18/03/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import Foundation

final class CommandsService {

    func add(command: Command) {

    }

    func getAll() -> [Command] {
        let commands = [Command(name: "Open Safari", args: ["open", "-a", "safari"]),
                        Command(name: "Open Telegram", args: ["open", "-a", "telegram"])]
        return commands
    }

}
