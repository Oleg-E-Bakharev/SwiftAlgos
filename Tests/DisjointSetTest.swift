//
//  DisjointSetTest.swift
//  SwiftAlgosTests
//
//  Created by Oleg Bakharev on 07.11.2020.
//  Copyright © 2020 Oleg Bakharev. All rights reserved.
//

import XCTest
@testable import SwiftAlgosLib

class DisjointSetTest: XCTestCase {

    var sut = DisjointSet(count: 0)

    override func setUpWithError() throws {
        sut.reserveCapacity(capacity: 5)
    }

    override func tearDownWithError() throws {
        sut = DisjointSet(count: 0)
    }

    func testConnectTwo() throws {
        XCTAssertFalse(sut.isConnected(0, 4))
        sut.connect(0, 4)
        XCTAssertTrue(sut.isConnected(0, 4))
        sut.connect(0, 4)
        XCTAssertTrue(sut.isConnected(0, 4))
        sut = DisjointSet(count: 5)
        XCTAssertFalse(sut.isConnected(0, 4))
        sut.connect(4, 0)
        XCTAssertTrue(sut.isConnected(0, 4))

        print(sut)
    }
    
    func testConnectTree() throws {
        XCTAssertFalse(sut.isConnected(0, 2))
        sut.connect(0, 1)
        sut.connect(1, 2)
        XCTAssertTrue(sut.isConnected(0, 2))
        
        sut = DisjointSet(count: 5)
        sut.connect(1, 2)
        sut.connect(0, 1)
        XCTAssertTrue(sut.isConnected(0, 2))

        print(sut)
    }
}
