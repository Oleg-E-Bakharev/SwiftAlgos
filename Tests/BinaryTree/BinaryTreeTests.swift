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
    typealias Tree = BinaryTree<Character>
    var tree = Tree()

    override func setUpWithError() throws {
        tree = []
    }

    override func tearDownWithError() throws {
        tree = []
    }

    func testInsertOne() throws {
        XCTAssertTrue(tree.isEmpty)
        XCTAssertFalse(tree.search("A"))
        XCTAssertFalse(tree.remove("A"))
        tree.insert("A")
        XCTAssertFalse(tree.search("0"))
        XCTAssertFalse(tree.search("B"))
        XCTAssertFalse(tree.isEmpty)
        XCTAssertTrue(tree.search("A"))
        tree.insert("A")
        XCTAssertTrue(tree.search("A"))
        XCTAssertTrue(tree.remove("A"))
        XCTAssertTrue(tree.isEmpty)
    }

    func testInsertTwo() throws {
        tree.insert(["B", "A"])
        XCTAssertTrue(tree.search("A"))
        XCTAssertTrue(tree.search("B"))
        tree.remove(["A", "B"])
        XCTAssertTrue(tree.isEmpty)
    }

    func testInsertSerial() throws {
        tree.insert(["A", "B", "C"])
        XCTAssertTrue(tree.search("A"))
        XCTAssertTrue(tree.search("B"))
        XCTAssertTrue(tree.search("C"))
        tree.remove(["B", "A", "C"])
        XCTAssertTrue(tree.isEmpty)
    }

    func testArrayLiteral() throws {
        tree = ["B", "A", "C"]
        XCTAssertTrue(tree.search("A"))
        XCTAssertTrue(tree.search("B"))
        XCTAssertTrue(tree.search("C"))
    }

    func testArrayRemoveLeft() throws {
        // Из-за рандомизации делаем цикл.
        for _ in 0..<10 {
            tree = ["B", "A"]
            XCTAssertTrue(tree.search("A"))
            XCTAssertTrue(tree.search("B"))
            XCTAssertTrue(tree.remove("A"))
            XCTAssertFalse(tree.search("A"))
            XCTAssertTrue(tree.search("B"))
            XCTAssertTrue(tree.remove("B"))
            XCTAssertFalse(tree.search("A"))
            XCTAssertFalse(tree.search("B"))
        }
    }

    func testArrayRemoveRight() throws {
        for _ in 0..<10 {
            tree = ["A", "B"]
            XCTAssertTrue(tree.search("A"))
            XCTAssertTrue(tree.search("B"))
            XCTAssertTrue(tree.remove("B"))
            XCTAssertFalse(tree.search("B"))
            XCTAssertTrue(tree.search("A"))
            XCTAssertTrue(tree.remove("A"))
            XCTAssertFalse(tree.search("A"))
            XCTAssertFalse(tree.search("B"))
        }
    }

    func testArrayRemoveBoth() throws {
        for _ in 0..<10 {
            tree = ["B", "A", "C"]
            XCTAssertTrue(tree.search("A"))
            XCTAssertTrue(tree.search("B"))
            XCTAssertTrue(tree.search("C"))
            XCTAssertTrue(tree.remove("B"))
            XCTAssertTrue(tree.search("A"))
            XCTAssertFalse(tree.search("B"))
            XCTAssertTrue(tree.search("C"))
        }
    }

    func testArrayEquatable() throws {
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
        rhs = ["B", "C", "A"]
        XCTAssertEqual(lhs, rhs)
    }

    func testArrayInsertRoot() throws {
        tree = ["B"]
        tree.insertToRoot("A")
        XCTAssert(tree.root?.value == "A")
        tree.insertToRoot("C")
        XCTAssert(tree.root?.value == "C")
        tree.insertToRoot("A")
        XCTAssert(tree.root?.value == "A")
        print(tree)
    }
    
    func testArrayMerge() throws {
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
        XCTAssert(tree == benchmark)

        tree = ["C", "B"]
        tree2 = ["A", "D"]
        tree.merge(to: &tree2)
        print(tree2)
        benchmark = ["A", "D", "C", "B"]
        XCTAssert(tree2 == benchmark)
    }

    func testStrangeRemove() throws {
        tree = ["2", "0", "1", "6", "5", "8", "3"]
        print(tree)
        tree.remove("2")
        print(tree)
    }
}
