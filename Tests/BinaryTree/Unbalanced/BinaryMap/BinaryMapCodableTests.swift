//
//  BinaryMapCodableTests.swift
//  SwiftAlgosTests
//
//  Created by Oleg Bakharev on 14.08.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

import XCTest
@testable import SwiftAlgosLib

class BinaryMapCodableTest: XCTestCase {

    typealias StringTree = BinaryMap<String, Int>
    var sut: StringTree!

    override func setUp() {
        sut = [:]
    }

    override func tearDown() {
        sut = nil
    }

    func testExample() throws {
        sut = ["si": 1, "vis": 2, "pacem": 3, "para": 4, "bellum": 5]
        let jsonData = try! JSONEncoder().encode(sut)
        let decoded = try! JSONDecoder().decode(StringTree.self, from: jsonData)
        XCTAssertEqual(sut, decoded)
    }
}
