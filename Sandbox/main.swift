//
//  main.swift
//  Algos
//
//  Created by Oleg Bakharev on 09.09.2020.
//  Copyright © 2020 Oleg Bakharev. All rights reserved.
//

import Foundation
import SwiftAlgosLib

do {
    var list = List<Int>()
    list.push(3)
    list.push(2)
    list.push(1)
    print(list)
}

do {
    var list = List<Int>()
    list.append(1)
    list.append(2)
    list.append(3)
    print(list)
}

do {
    var list: List = [1, 2, 3]
    print("Before inserting: \(list)")
    var middleNode = list.head!.next!
    for _ in 1...4 {
        middleNode = list.insert(-1, after: middleNode)
    }
    print("After inserting: \(list)")
}

do {
    var list: List = [1, 2, 3]
    print("Before removing at particular index: \(list)")
    let node = list.head!
    let removedValue = list.remove(after: node)!
    print("After removing at index 1: \(list)")
    print("Removed value: " + String(describing: removedValue))
}

do {
    var list = List<Int>()
    for i in 0...9 {
        list.append(i)
    }
    
    print("List: \(list)")
    print("Array containing first 3 elements: \(Array(list.prefix(3)))")
    print("Array containing last 3 elements: \(Array(list.suffix(3)))")
    let sum = list.reduce(0, +)
    print("Sum of all values: \(sum)")
}
