//
//  CommandsServiceTests.swift
//  ScriptyTests
//
//  Created by Ivan Smetanin on 18/03/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import XCTest
@testable import Scripty

final class CommandsServiceTests: XCTestCase {

    // MARK: - Properties

    private var service: ScriptsService?

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        service = ScriptsService()
    }
    
    override func tearDown() {
        super.tearDown()
        service = nil
    }

    // MARK: - Main tests

    func testThatServiceSavesCommandsCorrectly() {
        // given
        let script = Script(name: "MyCommand", content: "arg")
        // when
        service?.save(script: script)
        // then
        XCTAssert(service?.getAll().contains(where: { $0.name == script.name && $0.args == script.args }) ?? false)
    }

}
