//
//  BinaryTreeTest.swift
//  SwiftAlgosTests
//
//  Created by Oleg Bakharev on 16.02.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

import XCTest
@testable import SwiftAlgosLib

class BinaryTreeTests: XCTestCase {
    var tree = BinaryTree<String>()

    override func setUpWithError() throws {
        tree = []
    }

    override func tearDownWithError() throws {
        tree = []
    }

    func testInsertOne() throws {
        XCTAssertTrue(tree.isEmpty)
        XCTAssertFalse(tree.search(value: "A"))
        XCTAssertFalse(tree.remove("A"))
        tree.insert("A")
        XCTAssertFalse(tree.search(value: "0"))
        XCTAssertFalse(tree.search(value: "B"))
        XCTAssertFalse(tree.isEmpty)
        XCTAssertTrue(tree.search(value: "A"))
        tree.insert("A")
        XCTAssertTrue(tree.search(value: "A"))
        XCTAssertTrue(tree.remove("A"))
        XCTAssertTrue(tree.isEmpty)
    }

    func testInsertTwo() throws {
        tree.insert(["B", "A"])
        XCTAssertTrue(tree.search(value: "A"))
        XCTAssertTrue(tree.search(value: "B"))
        tree.remove(["A", "B"])
        XCTAssertTrue(tree.isEmpty)
    }

    func testInsertSerial() throws {
        tree.insert(["A", "B", "C"])
        XCTAssertTrue(tree.search(value: "A"))
        XCTAssertTrue(tree.search(value: "B"))
        XCTAssertTrue(tree.search(value: "C"))
        tree.remove(["B", "A", "C"])
        XCTAssertTrue(tree.isEmpty)
    }

    func testArrayLiteral() throws {
        tree = ["B", "A", "C"]
        XCTAssertTrue(tree.search(value: "A"))
        XCTAssertTrue(tree.search(value: "B"))
        XCTAssertTrue(tree.search(value: "C"))
    }

    func testArrayRemoveLeft() throws {
        tree = ["B", "A"]
        print(tree)
        XCTAssertTrue(tree.search(value: "A"))
        XCTAssertTrue(tree.search(value: "B"))
        XCTAssertTrue(tree.remove("A"))
        print(tree)
        XCTAssertFalse(tree.search(value: "A"))
        XCTAssertTrue(tree.search(value: "B"))
        XCTAssertTrue(tree.remove("B"))
        print(tree)
        XCTAssertFalse(tree.search(value: "A"))
        XCTAssertFalse(tree.search(value: "B"))
    }

    func testArrayRemoveRight() throws {
        tree = ["A", "B"]
        print(tree)
        XCTAssertTrue(tree.search(value: "A"))
        XCTAssertTrue(tree.search(value: "B"))
        XCTAssertTrue(tree.remove("B"))
        print(tree)
        XCTAssertFalse(tree.search(value: "B"))
        XCTAssertTrue(tree.search(value: "A"))
        XCTAssertTrue(tree.remove("A"))
        print(tree)
        XCTAssertFalse(tree.search(value: "A"))
        XCTAssertFalse(tree.search(value: "B"))
    }

    func testArrayRemoveBoth() throws {
        tree = ["B", "A", "C"]
        print(tree)
        XCTAssertTrue(tree.search(value: "A"))
        XCTAssertTrue(tree.search(value: "B"))
        XCTAssertTrue(tree.search(value: "C"))
        XCTAssertTrue(tree.remove("B"))
        XCTAssertTrue(tree.search(value: "A"))
        XCTAssertFalse(tree.search(value: "B"))
        XCTAssertTrue(tree.search(value: "C"))
        print(tree)
    }
}
