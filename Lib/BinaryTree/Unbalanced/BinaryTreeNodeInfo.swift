//
//  BinaryTreeNodeInfo.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 14.08.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

import Foundation

public extension BinaryTreeNode {
    var description: String { "\(key):\(value)" }
}

public extension BinaryTreeNode where Key == Value {
    var description: String { "\(value)" }
}
