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
    
    func testDouble() {
        sut.Push(value: 0, priority: 0)
        sut.Push(value: 0, priority: 0)
        XCTAssertEqual(sut.pop(), 0)
        XCTAssertEqual(sut.pop(), 0)
        
        XCTAssertTrue(sut.isEmpty)
        sut.Push(value: 0, priority: 0)
        sut.Push(value: 1, priority: 1)
        XCTAssertEqual(sut.pop(), 1)
        XCTAssertEqual(sut.pop(), 0)
        
        XCTAssertTrue(sut.isEmpty)
        sut.Push(value: 1, priority: 1)
        sut.Push(value: 0, priority: 0)
        XCTAssertEqual(sut.pop(), 1)
        XCTAssertEqual(sut.pop(), 0)
    }
    
    func testThree() {
        sut.Push(value: 0, priority: 0)
        sut.Push(value: 1, priority: 1)
        sut.Push(value: 2, priority: 2)
        XCTAssertEqual(sut.pop(), 2)
        XCTAssertEqual(sut.pop(), 1)
        XCTAssertEqual(sut.pop(), 0)
        XCTAssertTrue(sut.isEmpty)
        
        sut.Push(value: 0, priority: 0)
        sut.Push(value: 2, priority: 2)
        sut.Push(value: 1, priority: 1)
        XCTAssertEqual(sut.pop(), 2)
        XCTAssertEqual(sut.pop(), 1)
        XCTAssertEqual(sut.pop(), 0)
        XCTAssertTrue(sut.isEmpty)
        
        sut.Push(value: 2, priority: 2)
        sut.Push(value: 0, priority: 0)
        sut.Push(value: 1, priority: 1)
        XCTAssertEqual(sut.pop(), 2)
        XCTAssertEqual(sut.pop(), 1)
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
        sut = [(0,0), (1, 1), (2, 2)]
        XCTAssertEqual(String(describing: sut), "[2, 1, 0]")
    }
    
    func testStringPriorityQueue() {
        var bh = BinaryHeap<String, Double>()
        bh = [("a", 1), ("b", 2), ("c", 3)]
        XCTAssertEqual(String(describing: bh), "[c, b, a]")
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
