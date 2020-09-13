//
//  ListTest.swift
//  SwiftAlgosTests
//
//  Created by Oleg Bakharev on 13.09.2020.
//  Copyright © 2020 Oleg Bakharev. All rights reserved.
//

import XCTest
@testable import SwiftAlgosLib

class ListTest: XCTestCase {
    private var list: List<Int> = List()
    
    override func setUpWithError() throws {
        list = List()
    }

    override func tearDownWithError() throws {
        
    }

    func testEmpty() throws {
        XCTAssertTrue(list.isEmpty)
        list.push(1)
        XCTAssertFalse(list.isEmpty)
        list.pop()
        XCTAssertTrue(list.isEmpty)
    }
    
    func testPushOne() throws {
        list.push(1)
        XCTAssertEqual(list.pop(), 1)
    }
    
    func testAppendOne() throws {
        list.push(1)
        XCTAssertEqual(list.pop(), 1)
    }
    
    func testHeadEqualsTailAfterPushPop() throws {
        XCTAssertNil(list.head)
        XCTAssert(list.head === list.tail)
        list.push(1)
        XCTAssertNotNil(list.head)
        XCTAssert(list.head === list.tail)
        list.pop()
        XCTAssertNil(list.head)
        XCTAssert(list.head === list.tail)
    }

    func testHeadEqualsTailAfterAppendPop() throws {
        XCTAssertNil(list.head)
        XCTAssert(list.head === list.tail)
        list.append(1)
        XCTAssertNotNil(list.head)
        XCTAssert(list.head === list.tail)
        list.pop()
        XCTAssertNil(list.head)
        XCTAssert(list.head === list.tail)
    }

    func testPush() throws {
        list.push(1)
        list.push(2)
        XCTAssertEqual(list.pop(), 2)
        XCTAssertEqual(list.pop(), 1)
        XCTAssertTrue(list.isEmpty)
    }
    
    func testAppend() throws {
        list.append(1)
        list.append(2)
        XCTAssertEqual(list.pop(), 1)
        XCTAssertEqual(list.pop(), 2)
        XCTAssertTrue(list.isEmpty)
    }

    func testInsertAfterTail() throws {
        list.append(1)
        list.insert(2, after: list.tail!)
        list.insert(3, after: list.tail!)
        XCTAssertEqual(list.pop(), 1)
        XCTAssertEqual(list.pop(), 2)
        XCTAssertEqual(list.pop(), 3)
    }
    
    func testInsertAfterHead() throws {
        list.append(1)
        list.insert(2, after: list.head!)
        list.insert(3, after: list.head!)
        XCTAssertEqual(list.pop(), 1)
        XCTAssertEqual(list.pop(), 3)
        XCTAssertEqual(list.pop(), 2)
    }
    
    func testRemove() throws {
        list.append(1)
        XCTAssertNil(list.remove(after: list.head!))
        XCTAssertFalse(list.isEmpty)
        list.append(2)
        list.append(3)
        XCTAssertEqual(list.remove(after: list.head!), 2)
    }
    
    func testInitArrayLiteral() throws {
        list = [1, 2, 3]
        XCTAssertEqual(list.head!.value, 1)
        XCTAssertEqual(list.head!.next!.value, 2)
        XCTAssertEqual(list.tail!.value, 3)
    }
    
    func testSequence() throws {
        list = [1, 2, 3]
        var v = 1
        for i in list {
            XCTAssertEqual(i, v)
            v += 1
        }
    }
    
    func testDescripion() throws {
        XCTAssertEqual(String(describing: list), "Empty list")
        list.append(1)
        XCTAssertEqual(String(describing: list), "1")
        list.append(2)
        XCTAssertEqual(String(describing: list), "1 -> 2")
    }
    
    func testCopyOnWrite() throws {
        list = [1, 2, 3]
        var list1 = list
        list1.append(4)
        XCTAssertEqual(String(describing: list), "1 -> 2 -> 3")
        XCTAssertEqual(String(describing: list1), "1 -> 2 -> 3 -> 4")
    }
}
