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
        XCTAssert(menu?.items.count == 6)
    }

    func testThatDataDisplayManagerFillsMenuInRightOrder() {
        // given
        let commands: [Command] = [Command(name: "1", args: []), Command(name: "2", args: [])]
        // when
        ddm?.configure(with: commands)
        // then
        XCTAssert(menu?.items[0].title == L10n.Mainmenu.addItemTitle)
        XCTAssert(menu?.items[1].isSeparatorItem == true)
        XCTAssert(menu?.items[2].title == commands.first?.name)
        XCTAssert(menu?.items[3].title == commands.last?.name)
        XCTAssert(menu?.items[4].isSeparatorItem == true)
        XCTAssert(menu?.items[5].title == L10n.Mainmenu.quitItemTitle)
    }

    func testThatDataDisplayManagerInvokesCommandSelectionEvent() {
        // given
        let commands: [Command] = [Command(name: "1", args: []), Command(name: "2", args: [])]
        var commandSelectionEventInvoked: Bool = false
        ddm?.commandSelectionEvent += { command in
            commandSelectionEventInvoked = true
            XCTAssert(command.name == commands.first?.name)
        }
        // when
        ddm?.configure(with: commands)
        menu?.performActionForItem(at: 2)
        // then
        XCTAssert(commandSelectionEventInvoked == true)
    }

    func testThatDataDisplayManagerInvokesAddScriptEvent() {
        // given
        let commands: [Command] = [Command(name: "", args: []), Command(name: "", args: [])]
        var addEventInvoked: Bool = false
        ddm?.addEvent += {
            addEventInvoked = true
        }
        // when
        ddm?.configure(with: commands)
        menu?.performActionForItem(at: 0)
        // then
        XCTAssert(addEventInvoked == true)
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
        menu?.performActionForItem(at: (menu?.items.count ?? 0) - 1 )
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
