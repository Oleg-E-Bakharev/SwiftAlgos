//
//  SplayTree.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 26.02.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

import Foundation

public extension BinaryTree {
    mutating func splaySearch(value: T) -> Bool {
        Node.splaySearch(to: &root, value: value) != nil
    }
}

