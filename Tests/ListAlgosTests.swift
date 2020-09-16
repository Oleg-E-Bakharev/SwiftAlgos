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
        XCTAssertEqual(String(describing: list), "Empty list")
    }

    func testReverse() throws {
        list = [1, 2, 3, 4, 5]
        list.reverse()
        XCTAssertEqual(String(describing: list), "5 -> 4 -> 3 -> 2 -> 1")
    }
    
    func testMergeSortedEmpty() throws {
        var list2 = List<Int>()
        list = List.mergeSorted(&list, &list2, compare: <)
        XCTAssertEqual(String(describing: list), "Empty list")
    }
    
    func testMergeSorted() throws {
        list = [1, 3, 5]
        var list2: List<Int> = [2, 4, 6]
        list = List.mergeSorted(&list, &list2, compare: <)
        XCTAssertEqual(String(describing: list), "1 -> 2 -> 3 -> 4 -> 5 -> 6")
    }
    
    func testMergeSortedLeft() throws {
        list = [1, 3, 5]
        var list2 = List<Int>()
        list = List.mergeSorted(&list, &list2, compare: <)
        XCTAssertEqual(String(describing: list), "1 -> 3 -> 5")
    }
    
    func testMergeSortedRight() throws {
        list = [1, 3, 5]
        var list2 = List<Int>()
        list = List.mergeSorted(&list2, &list, compare: <)
        XCTAssertEqual(String(describing: list), "1 -> 3 -> 5")
    }

}
