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
    }

    func testExample() {
        // given
        let filename = "file.scripty"
        let content = "content"
        // when
        manager.write(filename: filename, content: content)
        // then
        XCTAssertEqual(manager.read(filename: filename), content)
    }


}
