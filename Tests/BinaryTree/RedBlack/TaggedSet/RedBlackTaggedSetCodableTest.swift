//
//  RedBlackSetCodableTest.swift
//  SwiftAlgosTests
//
//  Created by Oleg Bakharev on 08.08.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

import XCTest
@testable import SwiftAlgosLib

class RedBlackTaggedSetCodableTest: XCTestCase {

    typealias StringTree = RedBlackTaggedSet<String>
    var sut: StringTree!

    override func setUp() {
        sut = []
    }

    override func tearDown() {
        sut = nil
    }

    func testExample() throws {
        sut = ["si", "vis", "pacem", "para", "bellum"]
        let jsonData = try! JSONEncoder().encode(sut)
        let decoded = try! JSONDecoder().decode(StringTree.self, from: jsonData)
        XCTAssertEqual(sut, decoded)
    }
}
