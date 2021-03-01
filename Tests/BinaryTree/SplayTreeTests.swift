//
//  SplayTreeTests.swift
//  SwiftAlgosTests
//
//  Created by Oleg Bakharev on 01.03.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

import XCTest
@testable import SwiftAlgosLib

class SplayTreeTests: XCTestCase {
    typealias Tree = BinaryTree<Character>
    var tree = Tree()

    override func setUpWithError() throws {
        tree = []
    }

    override func tearDownWithError() throws {
        tree = []
    }

    func testSplaySearch1() throws {
        tree = ["B"]
        XCTAssertTrue(tree.splaySearch(value: "B"))
        print(tree)
        XCTAssertFalse(tree.splaySearch(value: "A"))
        XCTAssertFalse(tree.splaySearch(value: "C"))
        let benchmark: Tree = ["B"]
        XCTAssert(tree == benchmark)
    }

    func testSplaySearch2Left() throws {
        tree = ["B", "A"]
        XCTAssertTrue(tree.splaySearch(value: "B"))
        print(tree)
        XCTAssertTrue(tree.splaySearch(value: "A"))
        print(tree)
        let benchmark: Tree = ["A", "B"]
        XCTAssert(tree == benchmark)
    }

    func testSplaySearch2Right() throws {
        tree = ["A", "B"]
        XCTAssertTrue(tree.splaySearch(value: "A"))
        print(tree)
        XCTAssertTrue(tree.splaySearch(value: "B"))
        print(tree)
        let benchmark: Tree = ["B", "A"]
        XCTAssert(tree == benchmark)
    }

    func testSplaySearch3Left() throws {
        tree = ["C", "B", "A"]
        XCTAssertFalse(tree.splaySearch(value: "D"))
        print(tree)
        XCTAssertTrue(tree.splaySearch(value: "A"))
        print(tree)
        var benchmark: Tree = ["A", "B", "C"]
        XCTAssert(tree == benchmark)

        tree = ["C", "A", "B"]
        print(tree)
        XCTAssertFalse(tree.splaySearch(value: "D"))
        XCTAssertTrue(tree.splaySearch(value: "B"))
        print(tree)

        benchmark = ["B", "A", "C"]
        XCTAssert(tree == benchmark)
    }

    func testSplaySearch3Rgiht() throws {
        tree = ["A", "B", "C"]
        XCTAssertFalse(tree.splaySearch(value: "D"))
        print(tree)
        XCTAssertTrue(tree.splaySearch(value: "C"))
        print(tree)
        var benchmark: Tree = ["C", "B", "A"]
        XCTAssert(tree == benchmark)

        tree = ["A", "C", "B"]
        print(tree)
        XCTAssertFalse(tree.splaySearch(value: "D"))
        XCTAssertTrue(tree.splaySearch(value: "B"))
        print(tree)
        benchmark = ["B", "A", "C"]
        XCTAssert(tree == benchmark)
    }

    func testSplaySearchLoang() throws {
        tree = ["A", "B", "C", "D", "E", "F"]
        print(tree)
        XCTAssertTrue(tree.splaySearch(value: "F"))
        print(tree)
    }
}
