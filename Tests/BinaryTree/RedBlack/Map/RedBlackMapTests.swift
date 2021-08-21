//
//  RedBlackMapTests.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 21.08.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

import XCTest
@testable import SwiftAlgosLib

class RedBlackMapTests: XCTestCase {
    typealias Tree = RedBlackMap<Character, Int>
    var tree = Tree()

    override func setUp() {
        tree = [:]
    }

    override func tearDown() {
        tree = [:]
    }

    func testInsertOne() {
        XCTAssertTrue(tree.isEmpty)
        XCTAssertFalse(tree.has("A"))
        XCTAssertNil(tree.min())
        XCTAssertNil(tree.max())
        XCTAssertFalse(tree.remove("A"))
        tree.insert(key: "A", value: 1)
        XCTAssertFalse(tree.has("0"))
        XCTAssertFalse(tree.has("B"))
        XCTAssertFalse(tree.isEmpty)
        XCTAssertTrue(tree.has("A"))
        XCTAssertEqual(tree.search("A"), 1)
        XCTAssertEqual(tree.min(), 1)
        XCTAssertEqual(tree.max(), 1)
        tree.insert(key: "A", value: 1)
        XCTAssertTrue(tree.has("A"))
        XCTAssertEqual(tree.min(), 1)
        XCTAssertEqual(tree.max(), 1)
        XCTAssertTrue(tree.remove("A"))
        XCTAssertTrue(tree.isEmpty)
        XCTAssertNil(tree.min())
        XCTAssertNil(tree.max())
    }

    func testInsertTwo() {
        tree.insert([("B", 2), ("A", 1)]) // 100% coverage
        XCTAssertTrue(tree.has("A"))
        XCTAssertTrue(tree.has("B"))
        XCTAssertEqual(tree.min(), 1)
        XCTAssertEqual(tree.max(), 2)
        tree.remove(["A", "B"])
        XCTAssertTrue(tree.isEmpty)

    }

    func testInsertSerial() {
        tree = ["A": 1, "B": 2, "C": 3]
        XCTAssertTrue(tree.has("A"))
        XCTAssertTrue(tree.has("B"))
        XCTAssertTrue(tree.has("C"))
        XCTAssertEqual(tree.min(), 1)
        XCTAssertEqual(tree.max(), 3)
        tree.remove(["B", "A", "C"])
        print(tree)
        XCTAssertTrue(tree.isEmpty)
    }

    func testArrayRemoveLeft() {
        // Из-за рандомизации делаем цикл.
        for _ in 0..<10 {
            tree = ["B":  2, "A": 1]
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
            tree = ["A": 1, "B": 2]
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
            tree = ["B": 2, "A": 1, "C": 3]
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
        lhs = [:]
        rhs = [:]
        XCTAssertEqual(lhs, rhs)
        lhs = ["A": 1]
        XCTAssertNotEqual(lhs, rhs)
        rhs = ["A": 1]
        XCTAssertEqual(lhs, rhs)
        lhs = ["B": 2, "A": 1]
        rhs = ["B": 2, "C": 3]
        XCTAssertNotEqual(lhs, rhs)
        lhs = ["B": 2, "A": 1, "C": 3]
        print(lhs)
        rhs = ["B": 2, "C": 3, "A": 1]
        print(rhs)
        XCTAssertEqual(lhs, rhs)
    }

    func testStrangeRemove() {
        tree = ["2": 2, "0": 0, "1": 1, "6": 6, "5": 5, "8": 8, "3": 3]
        print(tree)
        tree.remove("2")
        print(tree)
    }

    func testCopyOnWrite() {
        tree = ["1": 1, "2": 2, "3": 3]
        let tree2 = tree
        XCTAssertEqual(tree, tree2)
        tree.insert(key: "4", value: 4)
        XCTAssertNotEqual(tree, tree2)
        let benchmark1: Tree = ["1": 1, "2": 2, "3": 3, "4": 4]
        XCTAssertEqual(tree, benchmark1)
        let benchmark2: Tree = ["1": 1, "2": 2, "3": 3]
        XCTAssertEqual(tree2, benchmark2)
    }

    func testSequence() {
        tree = ["B": 2, "A": 1, "C": 3, "D": 4, "E": 5]
        print(tree)
        var tree2 = Tree()
        for (key, value) in tree {
            print(key, value)
            tree2.insert(key: key, value: value)
        }
        XCTAssertEqual(tree, tree2)
    }

    func testSubscript() {
        tree["A"] = 1
        XCTAssertTrue(tree["A"] == 1)
        tree["A"] = nil
        XCTAssertTrue(tree["A"] == nil)
    }

    func testRemoveMax() {
        tree =  ["B": 2, "A": 1, "C": 3, "D": 4, "E": 5]
        while !tree.isEmpty {
            tree.removeMax()
        }
        XCTAssert(tree.isEmpty)
    }

    func testRemovemin() {
        tree =  ["B": 2, "A": 1, "C": 3, "D": 4, "E": 5]
        while !tree.isEmpty {
            tree.removeMin()
        }
        XCTAssert(tree.isEmpty)
    }

}
