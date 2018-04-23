//
//  Command.swift
//  Scripty
//
//  Created by Ivan Smetanin on 18/03/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import Foundation

struct Command {

    // MARK: - Constants

    let name: String
    let args: [String]

    // MARK: - Properties

    var argsStringRepresentation: String {
        return args.joined(separator: "\n")
    }

    // MARK: - Initialization and deinitialization

    /// Initializes object with name and arguments in string representation.
    ///
    /// - Parameters:
    ///   - name: Command name.
    ///   - script: Arguments in string representation.
    init(name: String, script: String) {
        self.name = name
        let normalizedString = script
            .replacingOccurrences(of: "\n", with: " ")
            .replacingOccurrences(of: "~", with: NSHomeDirectory())
        let args = normalizedString.split(separator: " ").map { String($0) }
        self.args = args
    }

    init(name: String, args: [String]) {
        self.name = name
        self.args = args
    }

}
