//
//  CommandsService.swift
//  Scripty
//
//  Created by Ivan Smetanin on 18/03/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import Foundation

final class CommandsService {

    // MARK: - Internal methods

    func save(command: Command) {
        FileSystemManager.shared.write(filename: command.name, content: command.argsStringRepresentation)
        Notifications.shared.commandsListChanged.invoke(with: ())
    }

    func getAll() -> [Command] {
        let files = FileSystemManager.shared.readAll()
        let commands = files.map { Command(name: $0.filename, script: $0.content) }
        return commands
    }

}
