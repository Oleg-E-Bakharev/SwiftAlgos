//
//  AlgosTests.swift
//  AlgosTests
//
//  Created by Oleg Bakharev on 09.09.2020.
//  Copyright © 2020 Oleg Bakharev. All rights reserved.
//

import XCTest
import SwiftAlgosLib

class AlgosTests: XCTestCase {
    private var stack = Stack<Int>()
    
    override func setUpWithError() throws {
        stack = Stack<Int>()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testEmpty() throws {
        XCTAssertNil(stack.pop())
    }

    func testWork() throws {
        stack.push(1)
        stack.push(2)
        stack.push(3)
        print(stack)
        try pops()
    }
    
    private func pops() throws {
        XCTAssertEqual(stack.pop(), 3)
        XCTAssertEqual(stack.pop(), 2)
        XCTAssertEqual(stack.pop(), 1)
        XCTAssertNil(stack.pop())

    }
    
    func testArray() throws {
        let array = [1, 2, 3]
        stack = Stack(array)
        try pops()
    }
    
    func testArrayLiteral() throws {
        stack = [1, 2, 3]
        try pops()
    }
    
    func testPeek() throws {
        XCTAssertNil(stack.peek())
        stack.push(1)
        XCTAssertEqual(stack.peek(), 1)
    }
    
    func testIsEmpty() throws {
        XCTAssertTrue(stack.isEmpty)
        stack.push(1)
        XCTAssertFalse(stack.isEmpty)
        stack.pop()
        XCTAssertTrue(stack.isEmpty)
    }
}
