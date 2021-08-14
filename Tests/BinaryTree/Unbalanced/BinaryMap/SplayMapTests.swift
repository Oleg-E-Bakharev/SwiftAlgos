//
//  SplayMapTests.swift
//  SwiftAlgosTests
//
//  Created by Oleg Bakharev on 14.08.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

import XCTest
@testable import SwiftAlgosLib

class SplayMapTests: XCTestCase {
    typealias Tree = BinaryMap<Character, Int>
    var tree = Tree()

    override func setUpWithError() throws {
        tree = [:]
    }

    override func tearDownWithError() throws {
        tree = [:]
    }

    func testSplayTreeEmpty() throws {
        XCTAssertNil(tree.splaySearch("A"))
    }

    func testSplaySearch1() throws {
        tree = ["B": 2]
        XCTAssertEqual(tree.splaySearch("B"), 2)
        XCTAssertNil(tree.splaySearch("A"))
        XCTAssertNil(tree.splaySearch("C"))
        let benchmark: Tree = ["B": 2]
        XCTAssert(tree == benchmark)
    }

    func testSplaySearch2Left() throws {
        tree = ["B": 2, "A": 1]
        XCTAssertEqual(tree.splaySearch("B"), 2)
        print(tree)
        XCTAssertEqual(tree.splaySearch("A"), 1)
        print(tree)
        let benchmark: Tree = ["A": 1, "B": 2]
        XCTAssert(tree == benchmark)
    }

    func testSplaySearch2Right() throws {
        tree = ["A": 1, "B": 2]
        XCTAssertEqual(tree.splaySearch("A"), 1)
        print(tree)
        XCTAssertEqual(tree.splaySearch("B"), 2)
        print(tree)
        let benchmark: Tree = ["B": 2, "A": 1]
        XCTAssert(tree == benchmark)
    }

    func testSplaySearch3Left() throws {
        tree = ["C": 3, "B": 2, "A": 1]
        XCTAssertNil(tree.splaySearch("D"))
        print(tree)
        XCTAssertEqual(tree.splaySearch("A"), 1)
        print(tree)
        var benchmark: Tree = ["A": 1, "B": 2, "C": 3]
        XCTAssert(tree == benchmark)

        tree = ["C": 3, "A": 1, "B": 2]
        print(tree)
        XCTAssertNil(tree.splaySearch("D"))
        XCTAssertEqual(tree.splaySearch("B"), 2)
        print(tree)

        benchmark = ["B": 2, "A": 1, "C": 3]
        XCTAssert(tree == benchmark)
    }

    func testSplaySearch3Rgiht() throws {
        tree = ["A": 1, "B": 2, "C": 3]
        XCTAssertNil(tree.splaySearch("D"))
        print(tree)
        XCTAssertEqual(tree.splaySearch("C"), 3)
        print(tree)
        var benchmark: Tree = ["C": 3, "B": 2, "A": 1]
        XCTAssert(tree == benchmark)

        tree = ["A": 1, "C": 3, "B": 2]
        print(tree)
        XCTAssertNil(tree.splaySearch("D"))
        XCTAssertEqual(tree.splaySearch("B"), 2)
        print(tree)
        benchmark = ["B": 2, "A": 1, "C": 3]
        XCTAssert(tree == benchmark)
    }

    func testSplaySearchLoang() throws {
        tree = ["A": 1, "B": 2, "C": 3, "D": 4, "E": 5, "F": 6]
        print(tree)
        XCTAssertEqual(tree.splaySearch("F"), 6)
        print(tree)
    }

    func testSplayInsert() throws {
        tree.splayInsert(key:"A", value: 1)
        print(tree)
        tree.splayInsert(key: "B", value: 2)
        print(tree)
        tree.splayInsert(key: "C", value: 3)
        var benchmark: Tree = ["C": 3, "B": 2, "A": 1]
        XCTAssertTrue(tree == benchmark)

        tree = [:]
        tree.splayInsert(key: "C", value: 3)
        print(tree)
        tree.splayInsert(key:"B", value: 2)
        print(tree)
        tree.splayInsert(key:"A", value: 1)
        benchmark = ["A": 1, "B": 2, "C": 3]
        XCTAssertTrue(tree == benchmark)
    }

    func testSplayRemove() throws {
        tree = ["A": 1, "B": 2, "C": 3, "D": 4, "E": 5, "F": 6]
        XCTAssertTrue(tree.splayRemove("E"))
        print(tree)
        let benchmark: Tree = ["F": 6, "B": 2, "A": 1, "D": 4, "C": 3]
        XCTAssertTrue(tree == benchmark)
    }

    func testSplaySubscript() {
        tree = ["A": 1, "B": 2, "C": 3, "D": 4, "E": 5]
        XCTAssertEqual(tree[splay: "E"], 5)
        tree[splay: "A"] = nil
        XCTAssertNil(tree[splay: "A"])
        tree[splay: "A"] = 1
        XCTAssertEqual(tree[splay: "A"], 1)
    }
}
