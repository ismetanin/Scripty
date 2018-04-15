//
//  FileSystemManager.swift
//  Scripty
//
//  Created by Ivan Smetanin on 15/04/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import Foundation

final class FileSystemManager {

    // MARK: - Constants

    static let shared = FileSystemManager()

    // MARK: - Initialization and deinitialization

    private init() {}

    // MARK: - Internal methods

    @discardableResult
    func write(filename: String, content: String) -> Bool {
        do {
            let dir = try FileManager.default.url(for: .applicationScriptsDirectory, in: .userDomainMask, appropriateFor: nil, create: true)

            let fileURL = dir.appendingPathComponent(filename)

            try content.write(to: fileURL, atomically: false, encoding: .utf8)
            return true
        }
        catch {
            return false
        }
    }

    func read(filename: String) -> String? {
        guard let dir = FileManager.default.urls(for: .applicationScriptsDirectory, in: .userDomainMask).first else {
            return nil
        }

        let fileURL = dir.appendingPathComponent(filename)

        //reading
        do {
            let content = try String(contentsOf: fileURL, encoding: .utf8)
            return content
        }
        catch {
            return nil
        }
    }

}
