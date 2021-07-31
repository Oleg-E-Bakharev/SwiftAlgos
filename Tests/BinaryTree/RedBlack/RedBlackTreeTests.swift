//
//  RedBlackTreeTests.swift
//  SwiftAlgosTests
//
//  Created by Oleg Bakharev on 31.07.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

import XCTest
@testable import SwiftAlgosLib

class RedBlackTreeTests: XCTestCase {
    typealias Tree = RedBlackTree<Character>

    var tree = Tree()

    override func setUp() {
        tree = ""
    }

    override func tearDown() {
        tree = ""
    }

    func testDisplay() {
        print(tree.diagram())
        tree = ["A"]
        print(tree.diagram())
        tree.insert("B")
        print(tree.diagram())
        tree.insert("C")
        print(tree.diagram())
        tree.insert("D")
        print(tree.diagram())
        tree.insert("E")
        print(tree.diagram())
        tree.insert("F")
        print(tree.diagram())
        tree.insert("G")
        print(tree.diagram())
        tree.insert("H")
        print(tree.diagram())
        tree.insert("I")
        print(tree.diagram())
        tree.insert("J")
        print(tree.diagram())
        tree.insert("K")
        print(tree.diagram())
        tree.insert("L")
        print(tree.diagram())
        tree.insert("M")
        print(tree.diagram())
        tree.insert("N")
        print(tree.diagram())
        tree.insert("O")
        print(tree.diagram())
        tree.insert("P")
        print(tree.diagram())
        tree.insert("Q")
        print(tree.diagram())
        tree.insert("R")
        print(tree.diagram())
        tree.insert("S")
        print(tree.diagram())
        tree.insert("T")
        print(tree.diagram())
        tree.insert("U")
        print(tree.diagram())
        tree.insert("V")
        print(tree.diagram())
        tree.insert("W")
        print(tree.diagram())
        tree.insert("X")
        print(tree.diagram())
        tree.insert("Y")
        print(tree.diagram())
        tree.insert("Z")
        print(tree.diagram())
        XCTAssert(true)
    }

    func testInsertOne() {
        XCTAssertTrue(tree.isEmpty)
        XCTAssertFalse(tree.search("A"))
        XCTAssertNil(tree.min())
        XCTAssertNil(tree.max())
//        XCTAssertFalse(tree.remove("A"))
        tree.insert("A")
        XCTAssertFalse(tree.search("0"))
        XCTAssertFalse(tree.search("B"))
        XCTAssertFalse(tree.isEmpty)
        XCTAssertTrue(tree.search("A"))
        XCTAssertEqual(tree.min(), "A")
        XCTAssertEqual(tree.max(), "A")
        tree.insert("A")
        XCTAssertTrue(tree.search("A"))
        XCTAssertEqual(tree.min(), "A")
        XCTAssertEqual(tree.max(), "A")
//        XCTAssertTrue(tree.remove("A"))
//        XCTAssertTrue(tree.isEmpty)
//        XCTAssertNil(tree.min())
//        XCTAssertNil(tree.max())
    }

    func testInsertTwo() {
        tree.insert(["B", "A"]) // 100% coverage
        XCTAssertTrue(tree.search("A"))
        XCTAssertTrue(tree.search("B"))
        XCTAssertEqual(tree.min(), "A")
        XCTAssertEqual(tree.max(), "B")
//        tree.remove(["A", "B"])
//        XCTAssertTrue(tree.isEmpty)
    }

    func testInsertSerial() {
        tree = "ABCDEF"
        XCTAssertTrue(tree.search("A"))
        XCTAssertTrue(tree.search("B"))
        XCTAssertTrue(tree.search("C"))
        XCTAssertEqual(tree.min(), "A")
        XCTAssertEqual(tree.max(), "F")
        print(tree.diagram())
//        tree.remove(["B", "A", "C"])
//        XCTAssertTrue(tree.isEmpty)
        tree = "FEDCBAG"
        XCTAssertTrue(tree.search("A"))
        XCTAssertTrue(tree.search("B"))
        XCTAssertTrue(tree.search("C"))
        XCTAssertEqual(tree.min(), "A")
        XCTAssertEqual(tree.max(), "G")
        print(tree.diagram())
    }

}
