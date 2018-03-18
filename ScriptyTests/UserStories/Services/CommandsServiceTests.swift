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

    private var service: CommandsService?

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        service = CommandsService()
    }
    
    override func tearDown() {
        super.tearDown()
        service = nil
    }

    // MARK: - Main tests

    func testThatServiceAddsCommandsCorrectly() {
        // given
        let command = Command(name: "MyCommand", args: ["arg"])
        // when
        service?.add(command: command)
        // then
        XCTAssert(service?.getAll().contains(where: { $0.name == command.name && $0.args == command.args }) ?? false)
    }

}
