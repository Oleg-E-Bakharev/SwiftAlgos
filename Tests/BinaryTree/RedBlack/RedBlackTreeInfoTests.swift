//
//  RedBlackTreeInfoTests.swift
//  SwiftAlgosTests
//
//  Created by Oleg Bakharev on 31.07.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

import XCTest
@testable import SwiftAlgosLib

class RedBlackTreeInfoTests: XCTestCase {
    var tree = RedBlackTree<Character>()

    override func setUpWithError() throws {
//        tree = ["A","B", "C", "D", "E", "F", "G", "H"]
        tree = ["D","B", "F", "A", "C", "E", "G", "H"]
    }

    override func tearDownWithError() throws {
        tree = []
    }

    func testDiagram() {
        let diagram = tree.diagram()
        print(diagram)
        let benchmark = """
            ┌bnil
          ┌bH
          │ └rG
        ┌bF
        │ └bE
        D
        │ ┌bC
        └bB
          └bA

        """
        XCTAssertEqual(diagram, benchmark)
    }

    func testCount() throws {
        XCTAssert(tree.count() == 8)
        tree = []
        XCTAssert(tree.count() == 0)
    }

    func testHeight() throws {
        XCTAssert(tree.height() == 4)
        tree = []
        XCTAssert(tree.height() == 0)
    }

    func testWidth() throws {
        XCTAssert(tree.width() == 4)
        XCTAssert(tree.width(stopAtDepth: 0) == 1)
        tree = []
        XCTAssert(tree.width() == 0)
    }

    func testLevelWidth() throws {
        XCTAssert(tree.levelWidths() == [1, 2, 4, 1])
        XCTAssert(tree.levelWidths(stopAtDepth: 0) == [1])
        tree = []
        XCTAssert(tree.levelWidths() == [])
    }
}
