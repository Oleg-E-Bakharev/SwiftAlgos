//
//  main.swift
//  Algos
//
//  Created by Oleg Bakharev on 09.09.2020.
//  Copyright © 2020 Oleg Bakharev. All rights reserved.
//

import Foundation
import SwiftAlgosLib

typealias EnumNode = EnumListNode<Int>

var el: EnumNode = [1, 2, 3, 4, 5]
print(el)
print(el.reverse())

typealias Node = ListNode<Int>

var li: EnumNode = [1, 2, 3, 4, 5]
print(li)
print(li.reverse())

el = [1]
print(el.getMiddle())
li = [1]
print(li.getMiddle())

el = [1, 2]
print(el.getMiddle())
li = [1, 2]
print(li.getMiddle())

el = [1, 2, 3]
print(el.getMiddle())
li = [1, 2, 3]
print(li.getMiddle())

el = [1, 2, 3, 4]
print(el.getMiddle())
li = [1, 2, 3, 4]
print(li.getMiddle())

el = [1, 2, 3, 4, 5]
print(el.getMiddle())
li = [1, 2, 3, 4, 5]
print(li.getMiddle())

el = [1, 2, 3, 4, 5, 6]
print(el.getMiddle())
li = [1, 2, 3, 4, 5, 6]
print(li.getMiddle())

el = [1, 2, 3, 4, 5, 6, 7]
print(el.getMiddle())
li = [1, 2, 3, 4, 5, 6, 7]
print(li.getMiddle())


