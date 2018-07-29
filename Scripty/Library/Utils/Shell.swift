//
//  Shell.swift
//  Scripty
//
//  Created by Ivan Smetanin on 18/03/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import Foundation

final class Shell {

    enum RunResult: Int32 {
        case success = 0
        case error = 1
    }

    @discardableResult
    static func run(_ arguments: [String]) -> RunResult {
        debugPrint("Task \(arguments) is running")
        let task = Process()
        task.launchPath = "/usr/bin/env"
        task.arguments = arguments
        task.launch()
        task.waitUntilExit()
        debugPrint("Result status: \(task.terminationStatus)")
        return RunResult(rawValue: task.terminationStatus) ?? .error
    }

}
