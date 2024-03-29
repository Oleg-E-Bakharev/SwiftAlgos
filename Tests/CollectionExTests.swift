//
//  MutableCollectionExTests.swift
//  SwiftAlgosTests
//
//  Created by Oleg Bakharev on 06.10.2020.
//  Copyright © 2020 Oleg Bakharev. All rights reserved.
//

import XCTest

class MutableCollectionExTests: XCTestCase {
    
    var sut: [Int] = []
    
    override func tearDownWithError() throws {
        sut = []
    }
        
    func testSafeMutableSubscript() throws {
        sut = [1, 2, 3]
        XCTAssertNil(sut[safe:-1])
        sut[safe: -1] = -1
        XCTAssertNil(sut[safe:-1])
        sut[safe: 0] = 4
        XCTAssertEqual(sut[safe:0], 4)
        sut[safe: 1] = 5
        XCTAssertEqual(sut[safe:1], 5)
        sut[safe: 2] = 6
        XCTAssertEqual(sut[safe:2], 6)
        sut[safe: 3] = 7
        XCTAssertNil(sut[safe:3])
    }

    func testReverseEmpty() throws {
        sut.reverseSubrange(0...0)
        XCTAssertTrue(sut.isEmpty)
    }
    
    func testReverseSingle() throws {
        sut = [1]
        
        sut.reverseSubrange(0...0)
        XCTAssertEqual(sut, [1])
        
        sut.reverseSubrange(1...1)
        XCTAssertEqual(sut, [1])

        sut.reverseSubrange(0..<1)
        XCTAssertEqual(sut, [1])
    }

    func testReverseDouble() throws {
        sut = [1, 2]
        sut.reverseSubrange(0...1)
        XCTAssertEqual(sut, [2, 1])

        sut = [1, 2]
        sut.reverseSubrange(1..<2)
        XCTAssertEqual(sut, [1, 2])

        sut = [1, 2]
        sut.reverseSubrange(0..<2)
        XCTAssertEqual(sut, [2, 1])
    }
    
    func testReverseTriple() throws {
        sut = [1, 2, 3]
        sut.reverseSubrange(0..<2)
        XCTAssertEqual(sut, [2, 1, 3])

        sut = [1, 2, 3]
        sut.reverseSubrange(1..<3)
        XCTAssertEqual(sut, [1, 3, 2])

        sut = [1, 2, 3]
        sut.reverseSubrange(0...2)
        XCTAssertEqual(sut, [3, 2, 1])
    }
    
    func testReverseQuad() throws {
        sut = [1, 2, 3, 4]
        sut.reverseSubrange(1..<4)
        XCTAssertEqual(sut, [1, 4, 3, 2])

        sut = [1, 2, 3, 4]
        sut.reverseSubrange(0...3)
        XCTAssertEqual(sut, [4, 3, 2, 1])
    }
    
    func testRotateEmpty() throws {
        sut.rotate(on: 0)
        XCTAssertTrue(sut.isEmpty)
    }
    
    func testRotateSingle() throws {
        sut = [1]
        
        sut.rotate(on: 0)
        XCTAssertEqual(sut, [1])
        
        sut.rotate(on: 1)
        XCTAssertEqual(sut, [1])
    }
    
    func testRotateDouble() throws {
        sut = [1, 2]
        sut.rotate(on: 0)
        XCTAssertEqual(sut, [1, 2])

        sut.rotate(on: 1)
        XCTAssertEqual(sut, [2, 1])
    }
    
    func testRotateTriple() throws {
        sut = [1, 2, 3]
        sut.rotate(on: 0)
        XCTAssertEqual(sut, [1, 2, 3])
        
        sut.rotate(on: 1)
        XCTAssertEqual(sut, [2, 3, 1])
        
        sut = [1, 2, 3]
        sut.rotate(on: 2)
        XCTAssertEqual(sut, [3, 1, 2])
    }
}
