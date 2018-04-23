//
//  FileSystemManagerTests.swift
//  ScriptyTests
//
//  Created by Ivan Smetanin on 15/04/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import XCTest
@testable import Scripty

final class FileSystemManagerTests: XCTestCase {

    private let manager = FileSystemManager.shared

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        manager.deleteAll()
    }

    func testThatFileCreatesSuccessfully() {
        // given
        let filename = "file.scripty"
        let content = "content"
        // when
        manager.write(filename: filename, content: content)
        // then
        XCTAssertNotEqual(manager.read(filename: filename), nil)
    }

    func testThatFileWritesContentSuccessfully() {
        // given
        let filename = "file.scripty"
        let content = "content"
        // when
        manager.write(filename: filename, content: content)
        // then
        XCTAssertEqual(manager.read(filename: filename), content)
    }

    func testThatFilesWriteSuccessfully() {
        // given
        let filename1 = "file1.scripty"
        let filename2 = "file2.scripty"
        let content1 = "content1"
        let content2 = "content2"
        // when
        manager.write(filename: filename1, content: content1)
        manager.write(filename: filename2, content: content2)

        // then
        let files = manager.readAll()
        XCTAssert(files.contains(where: { $0.filename == filename1 && $0.content == content1 }))
        XCTAssert(files.contains(where: { $0.filename == filename2 && $0.content == content2 }))
    }

    func testThatFileDeletesSuccessfully() {
        // given
        let filename = "file.scripty"
        let content = "content"
        // when
        manager.write(filename: filename, content: content)
        manager.delete(filename: filename)
        // then
        XCTAssertEqual(manager.read(filename: filename), nil)
    }

    func testThatFilesDeleteSuccessfully() {
        // given
        let filename1 = "file1.scripty"
        let filename2 = "file2.scripty"
        // when
        manager.write(filename: filename1, content: "")
        manager.write(filename: filename2, content: "")

        manager.deleteAll()
        // then
        XCTAssert(manager.readAll().isEmpty == true)
    }

}
