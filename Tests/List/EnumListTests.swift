//
//  EnumListTests.swift
//  SwiftAlgosTests
//
//  Created by Oleg Bakharev on 21.03.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

import XCTest
@testable import SwiftAlgosLib

class EnumListTests: XCTestCase {
    typealias Node = EnumListNode<Int>
    private var list: Node!
    
    override func setUp() {
        list = []
    }

    override func tearDown() {
        list = nil
    }

    func testEmpty() {
        XCTAssert(list.isEmpty)
        list.push(1)
        XCTAssert(!list.isEmpty)
    }

    func testEquatable() {
        list = [1]
        XCTAssertEqual(list, EnumListNode(1))
        XCTAssertNotEqual(list, EnumListNode(1, 2))
        XCTAssertNotEqual(list, EnumListNode(1, 2))
        list.push(2)
        XCTAssertNotEqual(list, EnumListNode(1, 2))
        XCTAssertEqual(list, EnumListNode(2, 1))
    }

    func test1() {
        list.push(1)
        XCTAssertFalse(list.isEmpty)
        XCTAssertEqual(list, EnumListNode(1))
        XCTAssertTrue(list.next.isEmpty)
    }

    func testDescripion() {
        XCTAssertEqual(String(describing: list!), "<Empty>")
        list.push(1)
        XCTAssertEqual(String(describing: list!), "1")
        list.push(2)
        XCTAssertEqual(String(describing: list!), "2->1")
    }

    func testReverse() {
        XCTAssertEqual(list.reversed(), EnumListNode())
        list = [1, 2]
        XCTAssertEqual(list.reversed(), EnumListNode(2, 1))
    }

    func testMiddle() {
        XCTAssertEqual(list.getMiddle(), EnumListNode())
        list = [1]
        XCTAssertEqual(list.getMiddle(), EnumListNode(1))
        list = [1, 2]
        XCTAssertEqual(list.getMiddle(), EnumListNode(2))
        list = [1, 2, 3]
        XCTAssertEqual(list.getMiddle(), EnumListNode(3))
        list = [1, 2, 3, 4]
        XCTAssertEqual(list.getMiddle(), EnumListNode(3, 4))
    }
}
