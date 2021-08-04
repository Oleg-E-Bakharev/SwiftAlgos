//
//  RedBlackTreeNode.swift
//  SwiftAlgosSandbox
//
//  Created by Oleg Bakharev on 25.07.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

public protocol RedBlackTreeNode: BinaryTreeNodeTraits where NodeRef: RedBlackTreeNode {
    static func isRed(_ node: NodeRef?) -> Bool
    static func setRed(_ node: inout NodeRef?, _ isRed: Bool)
}

public extension RedBlackTreeNode {
    /// Flips color of node and its children
    static func colorFlip(_ node: inout NodeRef?) {
        setRed(&node, !isRed(node))
        if var node = node {
            setRed(&node.left, !isRed(node.left))
            setRed(&node.right, !isRed(node.right))
        }
    }

    // right becomes node
    static func rotateLeft(_ node: inout NodeRef?) {
        var right = node?.right
        setRed(&right, isRed(node))
        setRed(&node, true) // We will rotate only red nodes
        node?.right = right?.left
        right?.left = node
        node = right
    }

    // left becomes node
    static func rotateRight(_ node: inout NodeRef?) {
        var left = node?.left
        setRed(&left, isRed(node))
        setRed(&node, true) // We will rotate only red nodes
        node?.left = left?.right
        left?.right = node
        node = left
    }

    static func insert(to node: inout NodeRef?, value: Value) {
        if node == nil {
            node = .init(value)
            setRed(&node, true)
            return
        }

        if var node = node {
            if value < node.value {
                insert(to: &node.left, value: value)
            } else {
                insert(to: &node.right, value: value)
            }
        }

        fix(&node)
    }

    static func fix(_ node: inout NodeRef?) {
        if isRed(node?.right) && !isRed(node?.left) {
            rotateLeft(&node)
        }
        if isRed(node?.left) && isRed(node?.left?.left) {
            rotateRight(&node)
        }
        if isRed(node?.left) && isRed(node?.right) {
            colorFlip(&node)
        }
    }

    static func advanceRedToLeft(at node: inout NodeRef?) {
        var right = node?.right
        colorFlip(&node)
        if isRed(right?.left) {
            rotateRight(&right)
            rotateLeft(&node)
            colorFlip(&node)
        }
    }

    static func advanceRedToRight(at node: inout NodeRef?) {
        if isRed(node?.left?.left) {
            rotateRight(&node)
            colorFlip(&node)
        }
    }

    static func delMax(at node: inout NodeRef?) {
        // Stretch tree to right an remove rightmost node
        if isRed(node?.left) {
            rotateRight(&node)
        }
        guard node?.right != nil else {
            node = nil
            return
        }
        if !isRed(node?.right) && !isRed(node?.right?.left) {
            advanceRedToRight(at: &node)
        }
        var right = node?.right
        delMax(at: &right)
        fix(&node)
    }

    static func delMin(at node: inout NodeRef?) {
        // Stretch tree to left an remove leftmost node
        guard node?.left != nil else {
            node = nil
            return
        }
        if !isRed(node?.left) && !isRed(node?.left?.left) {
            advanceRedToLeft(at: &node)
        }
        var left = node?.left
        delMin(at: &left)
        fix(&node)
    }

    static func remove(from link: inout NodeRef?, value: Value) -> Bool {
        guard let node = link else {
            return false
        }
        let result: Bool
        if value < node.value {
            // Go to left
            if !isRed(link?.left) && !isRed(link?.left?.left) {
                advanceRedToLeft(at: &link)
            }
            var left = link?.left
            result = remove(from: &left, value: value)
        } else {
            // Go to right
            if isRed(node.left) {
                rotateRight(&link)
            }

            // Check leaf equal
            if link?.right == nil && link?.value == value {
                link = nil
                return true
            }

            if !isRed(link?.right) && !isRed(link?.right?.left) {
                advanceRedToRight(at: &link)
            }

            if link?.value == value {
                // Equal and not leaf. Set value to min and del min.
                guard let minValue = link?.right?.min()?.value else {
                    fatalError("impossible behavior")
                }
                link?.value = minValue
                var right = link?.right
                delMin(at: &right)

                link = nil
                return true
            }
            var right = link?.right
            result = remove(from: &right, value: value)
        }
        if result {
            fix(&link)
        }
        return result
    }

//    bool del_(Link& h, K key) {
//        // Обходим склеивая 2-узлы.
//        bool result = false;
//
//        if (h == nullptr){
//            return false;
//        }
//
//        if (key < h->item) {
//            // Проход влево.
//            if (!isRed_(h->l) && !isRed_(h->l->l)) {
//                moveRedLeft_(h);
//            }
//            result = del_(h->l, key); // Идем влево.
//        } else {
//            if (isRed_(h->l)){
//                rotR_(h);
//            }
//
//            if (key == h->item && !h->r) { // Если равно и внизу просто удаляем.
//                delete h.ptr();
//                h.setBit(false);
//                h = nullptr;
//                return true;
//            }
//
//            if (!isRed_(h->r) && !isRed_(h->r->l)) {
//                moveRedRight_(h); // Продвигаем красноту вниз вправо.
//            }
//
//            if (key == h->item) { // Равно и не внизу меняем значение на минимальное и удаляем минимальный узел.
//                h->item = std::move(min_(h->r));
//                delMin_(h->r);
//                result = true;
//            } else {
//                result = del_(h->r, key); // Идем вправо.
//            }
//        }
//        if (result) {
//            fix_(h);
//        }
//        return result;
//    }

    var description: String { String(describing: value) }
}
