//
//  Script.swift
//  Scripty
//
//  Created by Ivan Smetanin on 18/03/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import Foundation

struct Script {

    // MARK: - Constants

    let name: String
    let content: String

    // MARK: - Properties

    var args: [String] {
        let normalizedString = content
            .replacingOccurrences(of: "\n", with: " ")
            .replacingOccurrences(of: "~", with: NSHomeDirectory())
        let args = normalizedString.split(separator: " ").map { String($0) }
        return args
    }

    // MARK: - Initialization and deinitialization

    init(name: String, content: String) {
        self.name = name
        self.content = content
    }
 
}
