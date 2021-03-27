//
//  ListCodableTest.swift
//  SwiftAlgosTests
//
//  Created by Oleg Bakharev on 27.03.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

import XCTest
@testable import SwiftAlgosLib

class ListCodableTest: XCTestCase {
    typealias StringList = List<String>
    var sut: List<String>!

    override func setUp() {
        sut = []
    }

    override func tearDown() {
        sut = nil
    }

    func testCoding() {
        sut = ["si", "vis", "pacem", "para", "bellum"]
        let jsonData = try! JSONEncoder().encode(sut)
        let decoded = try! JSONDecoder().decode(StringList.self, from: jsonData)
        XCTAssertEqual(sut, decoded)
    }
}
