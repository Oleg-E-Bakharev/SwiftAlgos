//
//  BinarySetTest.swift
//  SwiftAlgosTests
//
//  Created by Oleg Bakharev on 16.02.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

import XCTest
@testable import SwiftAlgosLib

class BinarySetTests: XCTestCase {
    typealias Tree = BinarySet<Character>
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

    func testInsertTwo() {
        tree.insert(["B", "A"]) // 100% coverage
        XCTAssertTrue(tree.has("A"))
        XCTAssertTrue(tree.has("B"))
        XCTAssertEqual(tree.min(), "A")
        XCTAssertEqual(tree.max(), "B")
        tree.remove(["A", "B"])
        XCTAssertTrue(tree.isEmpty)

    }

    func testInsertSerial() {
        tree = "ABC"
        XCTAssertTrue(tree.has("A"))
        XCTAssertTrue(tree.has("B"))
        XCTAssertTrue(tree.has("C"))
        XCTAssertEqual(tree.min(), "A")
        XCTAssertEqual(tree.max(), "C")
        tree.remove(["B", "A", "C"])
        XCTAssertTrue(tree.isEmpty)
    }

    func testArrayLiteral() {
        tree = "BAC"
        XCTAssertTrue(tree.has("A"))
        XCTAssertTrue(tree.has("B"))
        XCTAssertTrue(tree.has("C"))
        XCTAssertEqual(tree.min(), "A")
        XCTAssertEqual(tree.max(), "C")
    }

    func testArrayRemoveLeft() {
        // Из-за рандомизации делаем цикл.
        for _ in 0..<10 {
            tree = "BA"
            XCTAssertTrue(tree.has("A"))
            XCTAssertTrue(tree.has("B"))
            XCTAssertTrue(tree.remove("A"))
            XCTAssertFalse(tree.has("A"))
            XCTAssertTrue(tree.has("B"))
            XCTAssertTrue(tree.remove("B"))
            XCTAssertFalse(tree.has("A"))
            XCTAssertFalse(tree.has("B"))
        }
    }

    func testArrayRemoveRight() {
        for _ in 0..<10 {
            tree = "AB"
            XCTAssertTrue(tree.has("A"))
            XCTAssertTrue(tree.has("B"))
            XCTAssertTrue(tree.remove("B"))
            XCTAssertFalse(tree.has("B"))
            XCTAssertTrue(tree.has("A"))
            XCTAssertTrue(tree.remove("A"))
            XCTAssertFalse(tree.has("A"))
            XCTAssertFalse(tree.has("B"))
        }
    }

    func testArrayRemoveBoth() {
        for _ in 0..<10 {
            tree = "BAC"
            XCTAssertTrue(tree.has("A"))
            XCTAssertTrue(tree.has("B"))
            XCTAssertTrue(tree.has("C"))
            XCTAssertTrue(tree.remove("B"))
            XCTAssertTrue(tree.has("A"))
            XCTAssertFalse(tree.has("B"))
            XCTAssertTrue(tree.has("C"))
        }
    }

    func testArrayEquatable() {
        var lhs, rhs: Tree
        lhs = []
        rhs = []
        XCTAssertEqual(lhs, rhs)
        lhs = ["A"]
        XCTAssertNotEqual(lhs, rhs)
        rhs = ["A"]
        XCTAssertEqual(lhs, rhs)
        lhs = ["B", "A"]
        rhs = ["B", "C"]
        XCTAssertNotEqual(lhs, rhs)
        lhs = ["B", "A", "C"]
        print(lhs)
        rhs = ["B", "C", "A"]
        XCTAssertEqual(lhs, rhs)
    }

    func testArrayInsertRoot() {
        tree = ["B"]
        tree.insertToRoot("A")
        XCTAssert(tree.root?.value == "A")
        tree.insertToRoot("C")
        XCTAssert(tree.root?.value == "C")
        tree.insertToRoot("A")
        XCTAssert(tree.root?.value == "A")
        print(tree)
    }
    
    func testArrayMerge() {
        tree = []
        var tree2: Tree = ["A", "D"]
        tree.merge(to: &tree2)
        print(tree2)
        var benchmark: Tree = ["A", "D"]
        XCTAssert(tree2 == benchmark)

        tree = ["C", "B"]
        tree2 = []
        tree.merge(to: &tree2)
        print(tree2)
        benchmark = ["C", "B"]
        XCTAssert(tree2 == benchmark)

        tree = ["C", "B"]
        tree2 = ["A", "D"]
        tree2.merge(to: &tree)
        print(tree)
        benchmark = ["C", "B", "D", "A"]
        print(benchmark)
        XCTAssert(tree == benchmark)

        tree = ["C", "B"]
        tree2 = ["A", "D"]
        tree.merge(to: &tree2)
        print(tree2)
        benchmark = ["A", "D", "C", "B"]
        print(benchmark)
        XCTAssert(tree2 == benchmark)
    }

    func testStrangeRemove() {
        tree = ["2", "0", "1", "6", "5", "8", "3"]
        print(tree)
        tree.remove("2")
        print(tree)
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
        tree = "DCABHFEGIKLM"
        print(tree)
        let sequence: String = tree.reduce("", { x, y in x + "\(y)"})
        print(sequence)
        XCTAssertEqual(sequence, "DCABHFEGIKLM")
    }

    func testSubscript() {
        tree["A"] = "A"
        XCTAssertTrue(tree["A"] == "A")
        tree["A"] = nil
        XCTAssertTrue(tree["A"] == nil)
    }
}
