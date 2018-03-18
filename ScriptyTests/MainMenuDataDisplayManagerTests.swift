//
//  MainMenuDataDisplayManagerTests.swift
//  ScriptyTests
//
//  Created by Ivan Smetanin on 18/03/2018.
//  Copyright © 2018 Ivan Smetanin. All rights reserved.
//

import XCTest
@testable import Scripty

final class MainMenuDataDisplayManagerTests: XCTestCase {

    // MARK: - Properties

    private var menu: MockMenu?
    private var ddm: MainMenuDataDisplayManager?

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        let menu = MockMenu()
        let ddm = MainMenuDataDisplayManager(menu: menu)
        self.menu = menu
        self.ddm = ddm
        ddm.quitEvent += {
            debugPrint("lol")
        }
    }
    
    override func tearDown() {
        super.tearDown()
        menu = nil
        ddm = nil
    }

    // MARK: - Main tests

    func testThatDataDisplayManagerAddsItems() {
        // given
        let commands: [Command] = [Command(name: "", args: [])]
        // when
        ddm?.configure(with: commands)
        // then
        XCTAssert(menu?.addItemWasCalled == true)
    }

    func testThatDataDisplayManagerAddsCorrectNumberOfItems() {
        // given
        let commands: [Command] = [Command(name: "", args: []), Command(name: "", args: [])]
        // when
        ddm?.configure(with: commands)
        // then
        XCTAssert(menu?.items.count == 4)
    }

    func testThatDataDisplayManagerInvokesQuitEvent() {
        // given
        let commands: [Command] = [Command(name: "", args: []), Command(name: "", args: [])]
        var quitEventInvoked: Bool = false
        ddm?.quitEvent += {
            quitEventInvoked = true
        }
        // when
        ddm?.configure(with: commands)
        menu?.performActionForItem(at: 2)
        // then
        XCTAssert(quitEventInvoked == true)
    }

    // MARK: - Mocks

    private final class MockMenu: NSMenu {
        var addItemWasCalled: Bool = false

        override func addItem(_ newItem: NSMenuItem) {
            super.addItem(newItem)
            addItemWasCalled = true
        }
    }

}
