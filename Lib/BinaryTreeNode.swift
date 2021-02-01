//
//  BinaryTreeNode.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 04.01.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

import Foundation

public protocol BinaryTreeNode {
    associatedtype Value
    var value: Value { get set }
    var left: Self? { get set }
    var right: Self? { get set }
}
