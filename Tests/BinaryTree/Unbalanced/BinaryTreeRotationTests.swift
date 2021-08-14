//
//  BinarySetRotationTests.swift
//  SwiftAlgosTests
//
//  Created by Oleg Bakharev on 25.02.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

import XCTest
@testable import SwiftAlgosLib

class BinarySetRotationTests: XCTestCase {
    typealias Tree = BinarySet<Int>
    var tree = Tree()

    override func setUpWithError() throws {
        tree = [2, 1, 3]
    }

    override func tearDownWithError() throws {
        tree = []
    }

    func testRotateLeft() throws {
        print(tree)
        var root = tree.root
        Tree.Node.rotateLeft(&root)
        tree.root = root
        print(tree)
        let benchmark: Tree = [3, 2, 1]
        XCTAssert(tree == benchmark)
    }

    func testRotateRight() throws {
        print(tree)
        var root = tree.root
        Tree.Node.rotateRight(&root)
        tree.root = root
        print(tree)
        let benchmark: Tree = [1, 2, 3]
        XCTAssert(tree == benchmark)
    }
}
