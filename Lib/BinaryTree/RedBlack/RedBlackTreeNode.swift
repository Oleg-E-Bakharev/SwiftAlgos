//
//  RedBlackTreeNode.swift
//  SwiftAlgosSandbox
//
//  Created by Oleg Bakharev on 25.07.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

/// Left Leaning Red Black Tree
/// https://www.cs.princeton.edu/~rs/talks/LLRB/RedBlack.pdf
public protocol RedBlackTreeNode: BinaryTreeNodeTraits where NodeRef == Self {
    static func isRed(_ node: NodeRef?) -> Bool
    static func setRed(_ node: inout NodeRef?, _ isRed: Bool)
}

public extension RedBlackTreeNode {
    /// Split temporary 4-node to two 2-node and promoute red link up.
    /// Or perform reverse operation.
    private static func colorFlip(_ link: inout NodeRef?) {
        setRed(&link, !isRed(link))
        if var node = link {
            setRed(&node.left, !isRed(node.left))
            setRed(&node.right, !isRed(node.right))
        }
    }

    // right becomes node
    private static func rotateLeft(_ link: inout NodeRef?) {
        var right = link?.right
        setRed(&right, isRed(link))
        setRed(&link, true) // We will rotate only red nodes
        link?.right = right?.left
        right?.left = link
        link = right
    }

    // left becomes node
    private static func rotateRight(_ link: inout NodeRef?) {
        var left = link?.left
        setRed(&left, isRed(link))
        setRed(&link, true) // We will rotate only red nodes
        link?.left = left?.right
        left?.right = link
        link = left
    }

    static func insert(key: Key, value: Value, to link: inout NodeRef?) {
        if link == nil {
            link = Self(key: key, value: value)
            setRed(&link, true)
            return
        }

        if var node = link {
            if key < node.key {
                insert(key: key, value: value, to: &node.left)
            } else if key == node.key {
                link?.value = value
            } else {
                insert(key: key, value: value, to: &node.right)
            }
        }

        fix(&link)
    }

    private static func fix(_ link: inout NodeRef?) {
        // Split temporary 4-nodes to 2-nodes and balance.
        if isRed(link?.right) && !isRed(link?.left) {
            // Make red link on left
            rotateLeft(&link)
        }
        if isRed(link?.left) && isRed(link?.left?.left) {
            rotateRight(&link)
        }
        if isRed(link?.left) && isRed(link?.right) {
            colorFlip(&link)
        }
    }

    private static func advanceRedToLeft(at link: inout NodeRef?) {
        // Make 2-3 node on left
        // Invariant: either link.left or link.left.left is Red
        colorFlip(&link)
        if var node = link {
            if isRed(node.right?.left) {
                rotateRight(&node.right)
                rotateLeft(&link)
                colorFlip(&link)
            }
        }
    }

    private static func advanceRedToRight(at link: inout NodeRef?) {
        // Make 2- or 3-node on right
        // Invaiant: either link or link.right is Red
        colorFlip(&link)
        if isRed(link?.left?.left) {
            rotateRight(&link)
            colorFlip(&link)
        }
    }

    static func removeMax(at link: inout NodeRef?) {
        // Stretch tree to right an remove rightmost node
        if isRed(link?.left) {
            rotateRight(&link)
        }
        guard link?.right != nil else {
            link = nil
            return
        }
        if !isRed(link?.right) && !isRed(link?.right?.left) {
            advanceRedToRight(at: &link)
        }
        if var node = link {
            removeMax(at: &node.right)
        }
        fix(&link)
    }

    static func removeMin(at link: inout NodeRef?) {
        // Stretch tree to left an remove leftmost node
        guard link?.left != nil else {
            link = nil
            return
        }
        if !isRed(link?.left) && !isRed(link?.left?.left) {
            advanceRedToLeft(at: &link)
        }
        if var node = link {
            removeMin(at: &node.left)
        }
        fix(&link)
    }

    static func remove(_ key: Key, from link: inout NodeRef?) -> Bool {
        guard let node = link else {
            return false
        }
        
        let result: Bool
        if key < node.key {
            result = removeOnLeft(key, from: &link)
        } else { // right or equal
            result = removeSelfOrRight(key, from: &link)
        }
        if result {
            fix(&link)
        }
        return result
    }
    
    private static func removeOnLeft(_ key: Key, from link: inout NodeRef?) -> Bool {
        // We should remove node from 3- or temporary 4-node
        if !isRed(link?.left) && !isRed(link?.left?.left) {
            // We have 2-node on left. Make 3-node.
            advanceRedToLeft(at: &link)
        }
        var result = false
        if var node = link {
            result = remove(key, from: &node.left)
        }
        return result
    }
    
    private static func removeSelfOrRight(_ key: Key, from link: inout NodeRef?) -> Bool {
        if isRed(link?.left) {
            rotateRight(&link)
        }

        // Check leaf equal
        if link?.right == nil && link?.key == key {
            link = nil
            return true
        }

        if !isRed(link?.right) && !isRed(link?.right?.left) {
            advanceRedToRight(at: &link)
        }

        if link?.key == key {
            // Equal and not leaf. Set value to min and del min.
            if let minValue = link?.right?.min()?.value {
                link?.value = minValue
            }
            if var node = link {
                removeMin(at: &node.right)
            }
            return true
        }

        var result = false
        if var node = link {
            result = remove(key, from: &node.right)
        }
        return result
    }
}
