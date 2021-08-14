//
//  SplaySetTests.swift
//  SwiftAlgosTests
//
//  Created by Oleg Bakharev on 01.03.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

import XCTest
@testable import SwiftAlgosLib

class SplaySetTests: XCTestCase {
    typealias Tree = BinarySet<Character>
    var tree = Tree()

    override func setUpWithError() throws {
        tree = []
    }

    override func tearDownWithError() throws {
        tree = []
    }

    func testSplayTreeEmpty() throws {
        XCTAssertFalse(tree.splaySearch("A"))
    }

    func testSplaySearch1() throws {
        tree = ["B"]
        XCTAssertTrue(tree.splaySearch("B"))
        print(tree)
        XCTAssertFalse(tree.splaySearch("A"))
        XCTAssertFalse(tree.splaySearch("C"))
        print(tree)
        let benchmark: Tree = ["B"]
        XCTAssert(tree == benchmark)
    }

    func testSplaySearch2Left() throws {
        tree = ["B", "A"]
        XCTAssertTrue(tree.splaySearch("B"))
        print(tree)
        XCTAssertTrue(tree.splaySearch("A"))
        print(tree)
        let benchmark: Tree = ["A", "B"]
        XCTAssert(tree == benchmark)
    }

    func testSplaySearch2Right() throws {
        tree = ["A", "B"]
        XCTAssertTrue(tree.splaySearch("A"))
        print(tree)
        XCTAssertTrue(tree.splaySearch("B"))
        print(tree)
        let benchmark: Tree = ["B", "A"]
        XCTAssert(tree == benchmark)
    }

    func testSplaySearch3Left() throws {
        tree = ["C", "B", "A"]
        XCTAssertFalse(tree.splaySearch("D"))
        print(tree)
        XCTAssertTrue(tree.splaySearch("A"))
        print(tree)
        var benchmark: Tree = ["A", "B", "C"]
        XCTAssert(tree == benchmark)

        tree = ["C", "A", "B"]
        print(tree)
        XCTAssertFalse(tree.splaySearch("D"))
        XCTAssertTrue(tree.splaySearch("B"))
        print(tree)

        benchmark = ["B", "A", "C"]
        XCTAssert(tree == benchmark)
    }

    func testSplaySearch3Rgiht() throws {
        tree = ["A", "B", "C"]
        XCTAssertFalse(tree.splaySearch("D"))
        print(tree)
        XCTAssertTrue(tree.splaySearch("C"))
        print(tree)
        var benchmark: Tree = ["C", "B", "A"]
        XCTAssert(tree == benchmark)

        tree = ["A", "C", "B"]
        print(tree)
        XCTAssertFalse(tree.splaySearch("D"))
        XCTAssertTrue(tree.splaySearch("B"))
        print(tree)
        benchmark = ["B", "A", "C"]
        XCTAssert(tree == benchmark)
    }

    func testSplaySearchLoang() throws {
        tree = ["A", "B", "C", "D", "E", "F"]
        print(tree)
        XCTAssertTrue(tree.splaySearch("F"))
        print(tree)
    }

    func testSplayInsert() throws {
        tree.splayInsert("A")
        print(tree)
        tree.splayInsert("B")
        print(tree)
        tree.splayInsert("C")
        var benchmark: Tree = ["C", "B", "A"]
        XCTAssertTrue(tree == benchmark)

        tree = []
        tree.splayInsert("C")
        print(tree)
        tree.splayInsert("B")
        print(tree)
        tree.splayInsert("A")
        benchmark = ["A", "B", "C"]
        XCTAssertTrue(tree == benchmark)
    }

    func testSplayRemove() throws {
        tree = ["A", "B", "C", "D", "E", "F"]
        XCTAssertTrue(tree.splayRemove("E"))
        print(tree)
        let benchmark: Tree = ["F", "B", "A", "D", "C"]
        XCTAssertTrue(tree == benchmark)
    }
}
