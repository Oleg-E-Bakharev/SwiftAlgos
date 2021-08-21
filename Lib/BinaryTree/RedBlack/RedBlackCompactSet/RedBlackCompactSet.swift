//
//  RedBlackCompactSet.swift
//  SwiftAlgosSandbox
//
//  Created by Oleg Bakharev on 15.08.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

public protocol RedBlackCompactKey: Comparable {
    // invariant: defaultMin < defaultMax.
    static var defaultMin: Self { get }
    static var defaultMax: Self { get }
}

/// Must be individual per RedBlackCompactSet specialization!
public protocol RedBlackStaticData {
    static var minAnchor: AnyObject? { get set }
    static var maxAnchor: AnyObject? { get set }
}

public struct RedBlackCompactSet<T: RedBlackCompactKey, Storage: RedBlackStaticData> {
    public typealias Value = T
    public typealias Key = T

    public final class Node: RedBlackTreeNode, BinaryTreeNodeDeepCopy, BinaryTreeNodeTraits {
        private var _left: Node?
        private var _right: Node?
        private var minFakeNode: Node { Storage.minAnchor as! Node }
        private var maxFakeNode: Node { Storage.maxAnchor as! Node }

        public var value : T
        public var key: T { value }
        public var left: Node? {
            get {
                let node = Self.isRed(self) ? _right : _left
                return node?.key == .defaultMin ? nil : node
            }
            set {
                if Self.isRed(self) {
                    _right = newValue ?? minFakeNode
                } else {
                    _left = newValue ?? minFakeNode
                }
            }
        }

        public var right: Node? {
            get {
                let node = Self.isRed(self) ? _left : _right
                return node?.key == .defaultMax ? nil : node
            }
            set {
                if Self.isRed(self) {
                    _left = newValue ?? maxFakeNode
                } else {
                    _right = newValue ?? maxFakeNode
                }
            }
        }

        public convenience init(key: T, value: T) {
            assert(key == value)
            self.init(key)
            _left = minFakeNode
            _right = maxFakeNode
            var node: Node? = self
            Self.setRed(&node, true)
        }

        internal init(_ key: T) {
            self.value = key
        }

        @inline(__always)
        public static func isRed(_ node: Node?) -> Bool {
            guard let node = node else { return false }
            return node._left!.key > node._right!.key
        }

        public static func setRed(_ node: inout Node?, _ newStatus: Bool) {
            guard isRed(node) != newStatus else { return }
            guard let node = node else {
                return
            }
            swap(&node._left, &node._right)
            assert(isRed(node) == newStatus)
        }
    }

    public init() {
        Storage.minAnchor = Node(.defaultMin)
        Storage.maxAnchor = Node(.defaultMax)
    }

    public internal(set) var root: Node?

    // Marker for copy-on-write
    class UniqueMarker {}
    var uniqueMarker = UniqueMarker()
}

extension RedBlackCompactSet: BinaryTreeCopyOnWrite {
    public typealias NodeRef = Node
}

extension RedBlackCompactSet: BinaryTreeTraits {
    public func min() -> T? {
        treeMin()
    }

    public func max() -> T? {
        treeMax()
    }

    public mutating func insert(key: T, value: T) {
        copyNodesIfNotUnique()
        assert(key == value)
        Node.insert(key: key, value: value, to: &root)
    }

    public mutating func insert(_ key: T) {
        insert(key: key, value: key)
    }

    @discardableResult
    public mutating func remove(_ value: T) -> Bool {
        copyNodesIfNotUnique()
        return Node.remove(value, from: &root)
    }

    public mutating func removeMax() {
        copyNodesIfNotUnique()
        return Node.removeMax(at: &root)
    }

    public mutating func removeMin() {
        copyNodesIfNotUnique()
        return Node.removeMin(at: &root)
    }
}

extension RedBlackCompactSet: BinaryTreeSerialOperations {}

extension RedBlackCompactSet.Node: Equatable {
    public static func == (lhs: RedBlackCompactSet.Node, rhs: RedBlackCompactSet.Node) -> Bool {
        guard lhs.value == rhs.value,
              lhs.left == rhs.left,
              lhs.right == rhs.right
        else {
            return false
        }
        return true
    }
}

extension RedBlackCompactSet: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.root == rhs.root
    }
}

extension RedBlackCompactSet: CustomStringConvertible, BinaryTreeInfo {
    public func diagram() -> String {
        NodeRef.diagram(of: root)
    }

    public var description: String { diagram() }
}
