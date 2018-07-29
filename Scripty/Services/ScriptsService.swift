//
//  ScriptsService.swift
//  Scripty
//
//  Created by Ivan Smetanin on 18/03/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import Foundation

final class ScriptsService {

    // MARK: - Internal methods

    func save(script: Script) {
        FileSystemManager.shared.write(filename: script.name, content: script.content)
        Notifications.shared.scriptsListChanged.invoke(with: ())
    }

    func getAll() -> [Script] {
        let files = FileSystemManager.shared.readAll()
        let commands = files.map { Script(name: $0.filename, content: $0.content) }
        return commands
    }

}
