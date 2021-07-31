//
//  RedBlackTree.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 31.07.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//


public struct RedBlackTree<T: Comparable> {
    public typealias Value = T
    
    public final class Node: RedBlackTreeNode {
        public var value: T
        public var left: Node?
        public var right: Node?
        private var isRed: Bool

        public init(_ value: T) {
            self.value = value
            isRed = true
        }

        public static func isRed(_ node: RedBlackTree<T>.Node?) -> Bool {
            node?.isRed ?? false
        }

        public static func setRed(_ node: inout RedBlackTree<T>.Node?, _ isRed: Bool) {
            node?.isRed = isRed
        }
    }

    public internal(set) var root: Node?

    // Marker for copy-on-write
    private class UniqueMarker {}
    private var uniqueMarker = UniqueMarker()

    mutating func copyNodesIfNotUnique() {
        guard !isKnownUniquelyReferenced(&uniqueMarker) else {
            return
        }
        #if DEBUG
        print("*** \(#file) copy on write ***")
        #endif

        root = deepCopy(root)
    }

    private func deepCopy(_ node:Node?) -> Node? {
        guard let node = node else { return nil }
        let newNode = Node(node.value)
        newNode.left = deepCopy(node.left)
        newNode.right = deepCopy(node.right)
        return newNode
    }
}

extension RedBlackTree: BinaryTreeTraits {
    public func min() -> T? {
        treeMin()
    }

    public func max() -> T? {
        treeMax()
    }

    public mutating func insert(_ value: T) {
        copyNodesIfNotUnique()
        Node.insert(to: &root, value: value)
    }

    public mutating func remove(_ value: T) -> Bool {
        fatalError("not implemented yet")
    }
}

extension RedBlackTree: BinaryTreeSerialOperations {}
