//
//  RedBlackSetTests.swift
//  SwiftAlgosTests
//
//  Created by Oleg Bakharev on 31.07.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

import XCTest
@testable import SwiftAlgosLib

class RedBlackSetTests: XCTestCase {
    typealias Tree = RedBlackSet<Character>

    var tree = Tree()

    override func setUp() {
        tree = ""
    }

    override func tearDown() {
        tree = ""
    }

    func testInsertOne() {
        XCTAssertTrue(tree.isEmpty)
        XCTAssertFalse(tree.has("A"))
        XCTAssertNil(tree.min())
        XCTAssertNil(tree.max())
        XCTAssertFalse(tree.remove("A"))
        tree.insert("A")
        XCTAssertFalse(tree.has("0"))
        XCTAssertFalse(tree.has("B"))
        XCTAssertFalse(tree.isEmpty)
        XCTAssertTrue(tree.has("A"))
        XCTAssertEqual(tree.min(), "A")
        XCTAssertEqual(tree.max(), "A")
        tree.insert("A")
        XCTAssertTrue(tree.has("A"))
        XCTAssertEqual(tree.min(), "A")
        XCTAssertEqual(tree.max(), "A")
        XCTAssertTrue(tree.remove("A"))
        XCTAssertTrue(tree.isEmpty)
        XCTAssertNil(tree.min())
        XCTAssertNil(tree.max())
    }

    func testColorNotChangedAfterDoubleInsert() {
        tree = "ABC"
        print(tree.diagram())
        XCTAssertTrue(!Tree.Node.isRed(tree.root!.left))
        tree.insert("A")
        print(tree.diagram())
        XCTAssertTrue(tree.has("A"))
        XCTAssertTrue(!Tree.Node.isRed(tree.root!.left))
    }

    func testInsertTwo() {
        tree.insert(["B", "A"]) // 100% coverage
        XCTAssertTrue(tree.has("A"))
        XCTAssertTrue(tree.has("B"))
        XCTAssertFalse(tree.remove("0"))
        XCTAssertFalse(tree.remove("C"))
        XCTAssertEqual(tree.min(), "A")
        XCTAssertEqual(tree.max(), "B")
        tree.remove(["A", "B"])
        XCTAssertTrue(tree.isEmpty)
    }

    func testInsertSerial() {
        tree = ["A", "B", "C", "D", "E", "F"]
        XCTAssertTrue(tree.has("A"))
        XCTAssertTrue(tree.has("B"))
        XCTAssertTrue(tree.has("C"))
        XCTAssertEqual(tree.min(), "A")
        XCTAssertEqual(tree.max(), "F")
        print(tree.diagram())
        tree.remove(["B", "A", "C", "E", "F", "D"])
        XCTAssertTrue(tree.isEmpty)
        tree = "FEDCBAG"
        XCTAssertTrue(tree.has("A"))
        XCTAssertTrue(tree.has("B"))
        XCTAssertTrue(tree.has("C"))
        XCTAssertEqual(tree.min(), "A")
        XCTAssertEqual(tree.max(), "G")
        print(tree.diagram())
    }

    func testRemoveMax() {
        tree = "ABCDEFGHIJKLMNOPQRSUVWXYZ"
        tree.remove(["A","E","I","O","U","V","Y"])
        while !tree.isEmpty {
            tree.removeMax()
        }
        XCTAssert(tree.isEmpty)
    }

    func testRemovemin() {
        tree = "ABCDEF"
        while !tree.isEmpty {
            tree.removeMin()
        }
        XCTAssert(tree.isEmpty)
    }

    func testTreeLiterals() {
        tree = .init(unicodeScalarLiteral: "ñ")
        XCTAssertEqual(tree, Tree("ñ"))

        tree = .init(extendedGraphemeClusterLiteral: "🇷🇺")
        XCTAssertEqual(tree, Tree("🇷🇺"))
    }

    func testCopyOnWrite() {
        tree = "123"
        let tree2 = tree
        XCTAssertEqual(tree, tree2)
        tree.insert("4")
        XCTAssertNotEqual(tree, tree2)
        XCTAssertEqual(tree, Tree("1234"))
        XCTAssertEqual(tree2, Tree("123"))
    }

    func testSequence() {
        tree = "BACDE"
        print(tree)
        for item in tree {
            print(item)
        }
    }
}
