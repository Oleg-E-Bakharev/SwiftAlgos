//
//  BinarySetCopyOnWrite.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 03.08.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

import Foundation

protocol BinarySetCopyOnWrite {
    associatedtype NodeRef: BinarySetNodeDeepCopy where NodeRef.NodeRef == NodeRef
    associatedtype UniqueMarker: AnyObject

    var root: NodeRef? { get set }
    var uniqueMarker: UniqueMarker { get set }

    mutating func copyNodesIfNotUnique()
}

extension BinarySetCopyOnWrite {
    mutating func copyNodesIfNotUnique() {
        guard !isKnownUniquelyReferenced(&uniqueMarker) else {
            return
        }
        #if DEBUG
        print("*** \(#file) copy on write ***")
        #endif

        root = NodeRef.deepCopy(root)
    }
}
