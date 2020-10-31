//
//  BinaryHeapTests.swift
//  SwiftAlgosTests
//
//  Created by Oleg Bakharev on 23.10.2020.
//  Copyright © 2020 Oleg Bakharev. All rights reserved.
//

import XCTest
@testable import SwiftAlgosLib

class BinaryHeapTests: XCTestCase {
    var sut = BinaryHeap<Int, Int>()
    
    override func tearDownWithError() throws {
        sut = BinaryHeap<Int, Int>()
    }
    
    func testEmpty() throws {
        XCTAssertTrue(sut.isEmpty)
    }
    
    func testSingle() {
        sut.Push(value: 0, priority: 0)
        XCTAssertFalse(sut.isEmpty)
        XCTAssertEqual(sut.pop(), 0)
        XCTAssertTrue(sut.isEmpty)
    }
    
    func testArrayLiteral() {
        sut = [(0,0), (1, 1), (2, 2)]
        XCTAssertTrue(sut.checkValid())
        XCTAssertEqual(sut.pop(), 2)
        XCTAssertEqual(sut.pop(), 1)
        XCTAssertEqual(sut.pop(), 0)
        XCTAssertTrue(sut.isEmpty)
    }
    
    func testStringConversion() {
        
    }
    
    func testDouble() {
        sut.Push(value: 0, priority: 0)
        sut.Push(value: 0, priority: 0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
