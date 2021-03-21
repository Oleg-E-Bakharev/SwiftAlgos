//
//  ListAlgosTests.swift
//  SwiftAlgosTests
//
//  Created by Oleg Bakharev on 15.09.2020.
//  Copyright © 2020 Oleg Bakharev. All rights reserved.
//

import XCTest
@testable import SwiftAlgosLib

class ListAlgosTests: XCTestCase {

    private var list: List<Int> = List()
    
    override func setUpWithError() throws {
        list = List()
    }

    override func tearDownWithError() throws {
        
    }
    
    func testReverseEmpty() throws {
        list.reverse()
        XCTAssertTrue(list.isEmpty)
    }

    func testReverse() throws {
        list = [1, 2, 3, 4, 5]
        list.reverse()
        XCTAssertEqual(String(describing: list), "5 -> 4 -> 3 -> 2 -> 1")
    }
    
    func testMergeSortedEmpty() throws {
        var list2 = List<Int>()
        list.mergeSorted(&list2, compare: <)
        XCTAssertTrue(list.isEmpty)
        XCTAssertTrue(list2.isEmpty)
    }
    
    func testMergeSorted() throws {
        list = [1, 3, 5]
        var list2: List<Int> = [2, 4, 6]
        list.mergeSorted(&list2, compare: <)
        XCTAssertEqual(String(describing: list), "1 -> 2 -> 3 -> 4 -> 5 -> 6")
        XCTAssertTrue(list2.isEmpty)
    }

    func testMergeSorted2() throws {
        list = [2, 4, 6]
        var list2: List<Int> = [1, 3, 5]
        list.mergeSorted(&list2, compare: <)
        XCTAssertEqual(String(describing: list), "1 -> 2 -> 3 -> 4 -> 5 -> 6")
        XCTAssertTrue(list2.isEmpty)
    }

    func testHalveEmptyList() {
        let second = list.halve()
        XCTAssertTrue(list.isEmpty)
        XCTAssertTrue(second.isEmpty)
    }
    
    func testHalveSingleNodeList() throws {
        list = [1]
        let second = list.halve()
        XCTAssertEqual(String(describing: list), "1")
        XCTAssertTrue(second.isEmpty)
    }

    func testHalveDoubleNodeList() throws {
        list = [1, 2]
        let second = list.halve()
        XCTAssertEqual(String(describing: list), "1")
        XCTAssertEqual(String(describing: second), "2")
    }
    
    func testHalveTripleNodeList() throws {
        list = [1, 2, 3]
        let second = list.halve()
        XCTAssertEqual(String(describing: list), "1 -> 2")
        XCTAssertEqual(String(describing: second), "3")
    }

    func testHalveQuadNodeList() throws {
        list = [1, 2, 3, 4]
        let second = list.halve()
        XCTAssertEqual(String(describing: list), "1 -> 2")
        XCTAssertEqual(String(describing: second), "3 -> 4")
    }
    
    func testSortEmptyList() throws {
        list.sort(compare: <)
        XCTAssertTrue(list.isEmpty)
    }
    
    func testSortSingleNodeList() throws {
        list = [1]
        list.sort(compare: <)
        XCTAssertEqual(String(describing: list), "1")
    }
    
    func testSortDoubleNodeList() throws {
        list = [1, 2]
        list.sort(compare: <)
        XCTAssertEqual(String(describing: list), "1 -> 2")
        list = [2, 1]
        list.sort(compare: <)
        XCTAssertEqual(String(describing: list), "1 -> 2")
    }

    func testSortTripleNodeList() throws {
        list = [1, 2, 3]
        list.sort(compare: <)
        XCTAssertEqual(String(describing: list), "1 -> 2 -> 3")
        list = [2, 1, 3]
        list.sort(compare: <)
        XCTAssertEqual(String(describing: list), "1 -> 2 -> 3")
        list = [1, 3, 2]
        list.sort(compare: <)
        XCTAssertEqual(String(describing: list), "1 -> 2 -> 3")
        list = [3, 2, 1]
        list.sort(compare: <)
        XCTAssertEqual(String(describing: list), "1 -> 2 -> 3")
        list = [2, 3, 1]
        list.sort(compare: <)
        XCTAssertEqual(String(describing: list), "1 -> 2 -> 3")
        list = [2, 1, 1]
        list.sort(compare: <)
        XCTAssertEqual(String(describing: list), "1 -> 1 -> 2")
        list = [1, 2, 1]
        list.sort(compare: <)
        XCTAssertEqual(String(describing: list), "1 -> 1 -> 2")
        list = [1, 1, 1]
        list.sort(compare: <)
        XCTAssertEqual(String(describing: list), "1 -> 1 -> 1")
    }
}
