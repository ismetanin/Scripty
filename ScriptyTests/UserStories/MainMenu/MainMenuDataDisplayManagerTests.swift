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
        let scripts: [Script] = [Script(name: "", content: "")]
        // when
        ddm?.configure(with: scripts)
        // then
        XCTAssert(menu?.addItemWasCalled == true)
    }

    func testThatDataDisplayManagerAddsCorrectNumberOfItems() {
        // given
        let scripts: [Script] = [Script(name: "", content: ""), Script(name: "", content: "")]
        // when
        ddm?.configure(with: scripts)
        // then
        XCTAssert(menu?.items.count == 6)
    }

    func testThatDataDisplayManagerFillsMenuInRightOrder() {
        // given
        let scripts: [Script] = [Script(name: "1", content: ""), Script(name: "2", content: "")]
        // when
        ddm?.configure(with: scripts)
        // then
        XCTAssert(menu?.items[0].title == L10n.MainMenu.addItemTitle)
        XCTAssert(menu?.items[1].isSeparatorItem == true)
        XCTAssert(menu?.items[2].title == scripts.first?.name)
        XCTAssert(menu?.items[3].title == scripts.last?.name)
        XCTAssert(menu?.items[4].isSeparatorItem == true)
        XCTAssert(menu?.items[5].title == L10n.MainMenu.quitItemTitle)
    }

    func testThatDataDisplayManagerInvokesCommandSelectionEvent() {
        // given
        let scripts: [Script] = [Script(name: "1", content: ""), Script(name: "2", content: "")]
        var scriptSelectionEventWasInvoked: Bool = false
        ddm?.scriptSelectionEvent += { command in
            scriptSelectionEventWasInvoked = true
            XCTAssert(command.name == scripts.first?.name)
        }
        // when
        ddm?.configure(with: scripts)
        menu?.performActionForItem(at: 2)
        // then
        XCTAssert(scriptSelectionEventWasInvoked == true)
    }

    func testThatDataDisplayManagerInvokesAddScriptEvent() {
        // given
        let scripts: [Script] = [Script(name: "", content: ""), Script(name: "", content: "")]
        var addEventInvoked: Bool = false
        ddm?.addEvent += {
            addEventInvoked = true
        }
        // when
        ddm?.configure(with: scripts)
        menu?.performActionForItem(at: 0)
        // then
        XCTAssert(addEventInvoked == true)
    }

    func testThatDataDisplayManagerInvokesQuitEvent() {
        // given
        let scripts: [Script] = [Script(name: "", content: ""), Script(name: "", content: "")]
        var quitEventInvoked: Bool = false
        ddm?.quitEvent += {
            quitEventInvoked = true
        }
        // when
        ddm?.configure(with: scripts)
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
