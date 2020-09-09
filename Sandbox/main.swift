//
//  main.swift
//  Algos
//
//  Created by Oleg Bakharev on 09.09.2020.
//  Copyright © 2020 Oleg Bakharev. All rights reserved.
//

import Foundation
import SwiftAlgosLib

print("Hello, World!")

var stack = Stack<Int>()
stack.push(1)
stack.push(2)
stack.push(3)
stack.push(4)

print(stack)

if let poppedElement = stack.pop() { assert(4 == poppedElement)
  print("Popped: \(poppedElement)")
}
