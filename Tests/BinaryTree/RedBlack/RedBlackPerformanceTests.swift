//
//  RedBlackPerformanceTests.swift
//  SwiftAlgosTests
//
//  Created by Oleg Bakharev on 21.08.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

import XCTest
@testable import SwiftAlgosLib

extension Int: RedBlackCompactKey {
    public static var defaultMin: Int { Int.min }

    public static var defaultMax: Int { Int.max }
}

class RedBlackPerformanceTests: XCTestCase {

    private class StaticData: RedBlackStaticData {
        static var minAnchor: AnyObject?
        static var maxAnchor: AnyObject?
    }

    var array: [String] = []

    override func setUp() {
        array = (0..<10000)
            .map { "\($0)" }
            .shuffled()
    }

    override func tearDown() {
        array = []
    }

    func testSetPrformance() {
        var sut = Set<String>()
        self.measure {
            array.forEach { sut.insert($0) }
        }
    }

    func testRedBlackSetInsertPrformance() {
        typealias Tree = RedBlackSet<String>
        var sut = Tree()
        let size = class_getInstanceSize(Tree.Node.self)
        print("Size of RedBlackSet<String>.Node is \(size)")
        self.measure {
            array.forEach { sut.insert($0) }
        }
    }

    func testRedBlackCompactSetInsertPrformance() {
        typealias Tree = RedBlackCompactSet<String, StaticData>
        var sut = Tree()
        let size = class_getInstanceSize(Tree.Node.self)
        print("Size of RedBlackCompactSet<String>.Node is \(size)")
        self.measure {
            array.forEach { sut.insert($0) }
        }
    }

    func testRedBlackTaggedSetInsertPrformance() {
        typealias Tree = RedBlackTaggedSet<String>
        var sut = Tree()
        let size = class_getInstanceSize(Tree.Node.self)
        print("Size of RedBlackTaggedSet<String>.Node is \(size)")
        self.measure {
            array.forEach { sut.insert($0) }
        }
    }
}
