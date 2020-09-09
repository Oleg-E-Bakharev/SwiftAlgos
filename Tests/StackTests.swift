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

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testEmpty() throws {
        var stack = Stack<Int>()
        XCTAssertNil(stack.pop())
    }

    func testWork() throws {
        var stack = Stack<Int>()
        stack.push(1)
        stack.push(2)
        stack.push(3)
        stack.push(4)
        XCTAssertEqual(stack.pop(), 4)
        XCTAssertEqual(stack.pop(), 3)
        XCTAssertEqual(stack.pop(), 2)
        XCTAssertEqual(stack.pop(), 1)
        XCTAssertNil(stack.pop())
    }
}
