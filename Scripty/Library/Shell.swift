//
//  Shell.swift
//  Scripty
//
//  Created by Ivan Smetanin on 18/03/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import Foundation

final class Shell {

    @discardableResult
    static func run(_ arguments: [String]) -> String {
        let task = Process()
        task.launchPath = "/Users/ivansmetanin/Library/Developer/Xcode/DerivedData"
        task.arguments = arguments

        let pipe = Pipe()
        task.standardOutput = pipe
        task.launch()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: String.Encoding.utf8)!
        if output.count > 0 {
            //remove newline character.
            let lastIndex = output.index(before: output.endIndex)
            debugPrint(String(output[output.startIndex ..< lastIndex]))
            return String(output[output.startIndex ..< lastIndex])
        }
        return output
    }

}
