//
//  Shell.swift
//  Scripty
//
//  Created by Ivan Smetanin on 18/03/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import Foundation

final class Shell {

    // MARK: - Nested types

    enum RunResult {
        case success(output: String)
        case error(output: String)
    }

    // MARK: - Internal methods

    @discardableResult
    static func run(_ arguments: [String]) -> RunResult {
        print("Task \(arguments) is running")
        let res = system(arguments.joined(separator: " ") + " -A")
        print(res)
        return RunResult.success(output: "")
//
//        let process = Process()
//
//        var stdout: String = ""
//        let stdoutPipe = Pipe()
//        process.standardOutput = stdoutPipe
////        stdoutPipe.fileHandleForReading.readabilityHandler = { fh in
////            guard let out = String(data: fh.availableData, encoding: .ascii), !out.isEmpty else {
////                return
////            }
////            stdout.append(out)
////        }
//
//        var stderr: String = ""
//        let stderrPipe = Pipe()
//        process.standardError = stderrPipe
////        stderrPipe.fileHandleForReading.readabilityHandler = { fh in
////            guard let err = String(data: fh.availableData, encoding: .ascii), !err.isEmpty else {
////                return
////            }
////            stderr.append(err)
////        }
//
////        var inputPipe = Pipe()
////        process.standardInput = inputPipe
////        inputPipe.fileHandleForWriting.writeabilityHandler = { fh in
////            inputPipe.fileHandleForWriting.write("Vsdctevhtv".data(using: .ascii) ?? Data())
////            inputPipe.fileHandleForWriting.write("\n".data(using: .ascii) ?? Data())
////        }
//
//        process.launchPath = "/usr/bin/env"
//        process.arguments = arguments
//
//        do {
//            try process.run()
//        } catch {
//            return .error(output: error.localizedDescription)
//        }
//
//        process.waitUntilExit()
//        return resultFrom(terminationStatus: process.terminationStatus, stdout: stdout, stderr: stderr)
    }

    // MARK: - Private methods

    private static func resultFrom(terminationStatus: Int32, stdout: String, stderr: String) -> RunResult {
        switch terminationStatus {
        case 0:
            return .success(output: stdout)
        case 1:
            return .error(output: stderr)
        default:
            return .error(output: stderr)
        }
    }

}


/// Straight from C++, the `system(_:)` command.
///
/// **Note:** `system(_:)` runs commands in `sh` not `zsh`.
///
/// - Parameter cmd: The command to run.
/// - Returns: The exit code of `cmd`.
@available(iOS, unavailable, message: "System shell commands cannot be run on iOS.")
@available(watchOS, unavailable, message: "System shell commands cannot be run on watchOS.")
@available(tvOS, unavailable, message: "System shell commands cannot be run on tvOS.")
@discardableResult
public func system(_ cmd: String) -> Int {
    return Int(shellCMD_I(cmd))
}

/// Straight from C++, the `system(_:)` command. (Without generating error code.)
///
/// **Note:** `system(_:)` runs commands in `sh` not `zsh`.
///
/// - Parameter cmd: The command to run.
@available(iOS, unavailable, message: "System shell commands cannot be run on iOS.")
@available(iOSApplicationExtension, unavailable, message: "System shell commands cannot be run on iOS.")
@available(watchOS, unavailable, message: "System shell commands cannot be run on watchOS.")
@available(watchOSApplicationExtension, unavailable, message: "System shell commands cannot be run on watchOS.")
@available(tvOS, unavailable, message: "System shell commands cannot be run on tvOS.")
@available(tvOSApplicationExtension, unavailable, message: "System shell commands cannot be run on iOS.")
public func systemNoGen(_ cmd: String) {
    shellCMD_V(cmd)
}
